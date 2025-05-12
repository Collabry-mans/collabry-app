import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/services/navigation_service.dart';
import 'package:collabry/features/authentication/data/repository/refresh_token_repository.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:dio/dio.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final RefreshTokenRepository refreshTokenRepo;
  bool _isRefreshing = false;
  String? refreshToken;

  // Queue to hold requests that are waiting for token refresh
  final _pendingRequests = <RequestOptions>[];

  AuthInterceptor(this.dio, this.refreshTokenRepo);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip adding token for refresh token endpoint to avoid loops
    if (options.path == EndPoints.refreshToken) {
      return handler.next(options);
    }

    final accessToken = await secureStorage.read(key: accessTokenKey);

    if (accessToken != null && accessToken.isNotEmpty) {
      debugPrint('Adding token to request: ${options.path}');
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      debugPrint('No access token found in secure storage');
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final originalRequest = err.requestOptions;

    //* If the request that just failed was the refreshToken request itself, then something is seriously wrong
    if (originalRequest.path.contains(EndPoints.refreshToken)) {
      debugPrint('Error during token refresh operation');
      await _handleTokenRefreshFailure();
      return handler.next(err);
    }

    if ((err.response?.statusCode == 401 ||
            err.response?.statusCode == 403 ||
            err.response?.statusCode == 500) &&
        !_isRefreshing) {
      debugPrint(
          'Auth error ${err.response?.statusCode}: ${err.response?.data}');

      if (await _isRefreshTokenNullOrEmpty()) {
        debugPrint('Not attempting token refresh - conditions not met');
        return handler.next(err);
      }

      // Queue the original request for retry after refresh
      _pendingRequests.add(originalRequest);

      synchronized(() async {
        if (!_isRefreshing) {
          _isRefreshing = true;
          try {
            if (await _isRefreshTokenNullOrEmpty()) {
              debugPrint('No refresh token available');
              await _handleTokenRefreshFailure();
              _isRefreshing = false;
              return handler.next(err);
            }

            final newTokens =
                await refreshTokenRepo.refreshToken(refreshToken!);

            if (newTokens == null) {
              debugPrint('Refresh token repo returned null');
              await _handleTokenRefreshFailure();
              _isRefreshing = false;
              return handler.next(err);
            }

            // Process all pending requests with the new token
            await _processPendingRequests(newTokens.accessToken!);

            // Resolve the original request with the response from retry
            final retryResponse =
                await _retryRequest(originalRequest, newTokens.accessToken!);
            _isRefreshing = false;
            return handler.resolve(retryResponse);
          } catch (e) {
            debugPrint('Token refresh failed: $e');
            await _handleTokenRefreshFailure();
            _isRefreshing = false;
            return handler.next(err);
          }
        } else {
          // Another thread is already refreshing, just queue this request
          debugPrint(
              'Token refresh already in progress, queuing request: ${originalRequest.path}');
          _pendingRequests.add(originalRequest);
        }
      });
    } else {
      // For non-auth errors or if already refreshing, just pass through
      return handler.next(err);
    }
  }

  // Processes all pending requests with the new access token
  Future<void> _processPendingRequests(String newAccessToken) async {
    debugPrint(
        'Processing ${_pendingRequests.length} pending requests with new token');

    // Create a copy to avoid modification during iteration
    final requests = List<RequestOptions>.from(_pendingRequests);
    _pendingRequests.clear();

    // Retry each request with new token
    for (var request in requests) {
      try {
        await _retryRequest(request, newAccessToken);
      } catch (e) {
        debugPrint('Error retrying request: $e');
      }
    }
  }

  /// Retries a request with a new access token
  Future<Response> _retryRequest(
      RequestOptions request, String newAccessToken) async {
    request.headers['Authorization'] = 'Bearer $newAccessToken';

    final options = Options(
      method: request.method,
      headers: request.headers,
    );

    debugPrint('Retrying request: ${request.path}');
    return await dio.request(
      request.path,
      data: request.data,
      queryParameters: request.queryParameters,
      options: options,
    );
  }

  Future<void> _handleTokenRefreshFailure() async {
    debugPrint('Handling token refresh failure - clearing tokens');
    await secureStorage.deleteAll();
    _pendingRequests.clear();
    NavigationService.navigateAndRemoveUntil(Routes.logInScreen);
  }

  Future<bool> _isRefreshTokenNullOrEmpty() async {
    refreshToken = await secureStorage.read(key: refreshTokenKey);
    return refreshToken.isNullOrEmpty();
  }

  /// Simple synchronization mechanism for critical sections
  Future<void> synchronized(Future<void> Function() criticalSection) async {
    try {
      await criticalSection();
    } catch (e) {
      debugPrint('Error in synchronized block: $e');
      rethrow;
    }
  }
}
