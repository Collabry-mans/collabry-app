import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions/string_extension.dart';
import 'package:collabry/core/services/navigation_service.dart';
import 'package:collabry/features/authentication/data/model/refresh_token_model.dart';
import 'package:collabry/features/authentication/data/repository/refresh_token_repository.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:dio/dio.dart';
import 'package:collabry/core/utils/app_constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final RefreshTokenRepository refreshTokenRepo;
  bool _isRefreshing = false;

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
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRefreshToken(err)) {
      return handler.next(err);
    }

    // Prevent multiple simultaneous refresh attempts
    if (_isRefreshing) {
      return handler.next(err);
    }
    _isRefreshing = true;

    try {
      final refreshToken = await secureStorage.read(key: refreshTokenKey);

      if (refreshToken.isNullOrEmpty()) {
        await _handleAuthFailure();
        return handler.next(err);
      }

      final RefreshTokenModel? newTokens =
          await refreshTokenRepo.refreshToken(refreshToken!);

      if (newTokens?.accessToken != null) {
        // Retry the original request with new token
        final response = await _retryOriginalRequest(
            request: err.requestOptions,
            newAccessToken: newTokens!.accessToken!);
        handler.resolve(response);
      } else {
        await _handleAuthFailure();
        handler.next(err);
      }
    } catch (e) {
      await _handleAuthFailure();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  bool _shouldRefreshToken(DioException err) {
    return (err.response?.statusCode == 401 ||
            err.response?.statusCode == 403 ||
            err.response?.statusCode == 500) &&
        !_isAuthEndpoint(err.requestOptions.path);
  }

  bool _isAuthEndpoint(String path) {
    return path.contains(EndPoints.refreshToken) ||
        path.contains(EndPoints.logIn) ||
        path.contains(EndPoints.signUP);
  }

  Future<Response> _retryOriginalRequest(
      {required RequestOptions request, required String newAccessToken}) async {
    request.headers['Authorization'] = 'Bearer $newAccessToken';

    return await dio.request(
      request.path,
      data: request.data,
      queryParameters: request.queryParameters,
      options: Options(
        method: request.method,
        headers: request.headers,
      ),
    );
  }

  Future<void> _handleAuthFailure() async {
    await secureStorage.deleteAll();
    NavigationService.navigateAndRemoveUntil(Routes.logInScreen);
  }
}
