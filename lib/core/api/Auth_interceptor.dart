import 'dart:async';
import 'package:dio/dio.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions/string_extension.dart';
import 'package:collabry/core/services/navigation_service.dart';
import 'package:collabry/features/authentication/data/repository/refresh_token_repository.dart';
import 'package:collabry/core/di/di.dart';
import 'package:collabry/core/utils/app_constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final RefreshTokenRepository refreshTokenRepo;
  bool _isRefreshing = false;
  final List<_QueuedRequest> _queuedRequests = [];

  AuthInterceptor(this.dio, this.refreshTokenRepo);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    final accessToken = await secureStorage.read(key: accessTokenKey);
    if (!accessToken.isNullOrEmpty()) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRefreshToken(err)) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _queuedRequests.add(_QueuedRequest(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;

    try {
      final refreshToken = await secureStorage.read(key: refreshTokenKey);

      if (refreshToken.isNullOrEmpty()) {
        await _handleAuthFailure();
        _processQueuedRequests(err);
        return handler.next(err);
      }

      final newTokens = await refreshTokenRepo.refreshToken(refreshToken!);

      if (newTokens != null) {
        await _saveNewTokens(
            accessToken: newTokens.accessToken!,
            refreshToken: newTokens.refreshToken!);
        final accessToken = newTokens.accessToken!;

        // Retry the original request
        await _retryRequest(err.requestOptions, handler, accessToken);

        // Process all queued requests
        for (final queued in _queuedRequests) {
          await _retryRequest(
              queued.requestOptions, queued.handler, accessToken);
        }
      } else {
        await _handleAuthFailure();
        _processQueuedRequests(err);
        handler.next(err);
      }
    } catch (e) {
      await _handleAuthFailure();
      _processQueuedRequests(err);
      handler.next(err);
    } finally {
      _isRefreshing = false;
      _queuedRequests.clear();
    }
  }

  bool _shouldRefreshToken(DioException err) {
    final code = err.response?.statusCode;
    final path = err.requestOptions.path;
    return (code == 401 || code == 403 || code == 500) &&
        !_isAuthEndpoint(path);
  }

  bool _isAuthEndpoint(String path) {
    return path.contains(EndPoints.refreshToken) ||
        path.contains(EndPoints.logIn) ||
        path.contains(EndPoints.signUP);
  }

  Future<void> _saveNewTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await secureStorage.write(key: accessTokenKey, value: accessToken);
    await secureStorage.write(key: refreshTokenKey, value: refreshToken);
  }

  Future<void> _retryRequest(
    RequestOptions request,
    ErrorInterceptorHandler handler,
    String accessToken,
  ) async {
    try {
      request.headers['Authorization'] = 'Bearer $accessToken';
      final response = await dio.request(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method,
          headers: request.headers,
          contentType: request.contentType,
          responseType: request.responseType,
          validateStatus: request.validateStatus,
          receiveDataWhenStatusError: request.receiveDataWhenStatusError,
        ),
        cancelToken: request.cancelToken,
        onReceiveProgress: request.onReceiveProgress,
        onSendProgress: request.onSendProgress,
      );

      handler.resolve(response);
    } catch (e) {
      handler.next(e is DioException
          ? e
          : DioException(requestOptions: request, error: e));
    }
  }

  Future<void> _handleAuthFailure() async {
    await secureStorage.deleteAll();
    NavigationService.navigateAndRemoveUntil(Routes.logInScreen);
  }

  // Process queued requests when refresh fails
  void _processQueuedRequests(DioException originalError) {
    for (final queued in _queuedRequests) {
      queued.handler.next(originalError);
    }
  }
}

class _QueuedRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _QueuedRequest(this.requestOptions, this.handler);
}
