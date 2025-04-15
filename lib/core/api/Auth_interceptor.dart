// ignore_for_file: file_names
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/features/authentication/data/model/refresh_token_model.dart';
import 'package:dio/dio.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStorage.read(key: accessTokenKey);

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      // Log for debugging that no token was found
      debugPrint('No access token found in secure storage');
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Add 403 to the list of status codes that trigger token refresh
    if ((err.response?.statusCode == 401 ||
            err.response?.statusCode == 403 ||
            err.response?.statusCode == 500 ||
            err.response?.statusCode == 400) &&
        !_isRefreshing) {
      // Log the error for debugging
      debugPrint(
          'Intercepted error ${err.response?.statusCode}: ${err.response?.data}');

      final originalRequest = err.requestOptions;
      _isRefreshing = true;

      try {
        final refreshToken = await secureStorage.read(key: refreshTokenKey);

        if (refreshToken != null && refreshToken.isNotEmpty) {
          debugPrint('Attempting to refresh token...');

          final RefreshTokenRepository refreshRepo =
              RefreshTokenRepository(dio);
          final newTokens = await refreshRepo.refreshToken(refreshToken);

          debugPrint('Token refresh successful');
          debugPrint(
              'New access token length: ${newTokens.accessToken!.length}');

          // Update the original request with the new token
          originalRequest.headers['Authorization'] =
              'Bearer ${newTokens.accessToken}';

          // Retry the original request
          debugPrint('Retrying original request to: ${originalRequest.path}');
          final response = await dio.fetch(originalRequest);

          _isRefreshing = false;
          return handler.resolve(response);
        } else {
          debugPrint('No refresh token available');
          // No refresh token available, likely need to re-login
          _isRefreshing = false;

          // You might want to navigate to login screen here
          // or emit an event that the user needs to re-authenticate
        }
      } catch (e) {
        debugPrint('Error during token refresh: $e');
        _isRefreshing = false;
        await secureStorage.deleteAll();

        // Add specific handling for refresh token errors
        // For example, redirect to login
      }
    }

    _isRefreshing = false;
    return handler.next(err);
  }
}

class RefreshTokenRepository {
  final Dio dio;
  RefreshTokenRepository(this.dio);

  Future<RefreshTokenModel> refreshToken(String refreshToken) async {
    try {
      // Create a new Dio instance for refresh token requests to avoid interceptors loop
      final tokenDio = Dio(BaseOptions(
        baseUrl: dio.options.baseUrl,
        connectTimeout: dio.options.connectTimeout,
        receiveTimeout: dio.options.receiveTimeout,
      ));

      debugPrint('Sending refresh token request to: ${EndPoints.refreshToken}');

      final Response response = await tokenDio.post(
        EndPoints.refreshToken,
        data: {ApiKeys.refreshToken: refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('Refresh token response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: RequestOptions(path: EndPoints.refreshToken),
          response: response,
          error: 'Failed to refresh token: ${response.statusCode}',
        );
      }

      final newTokens = RefreshTokenModel.fromJson(response.data);

      // Check if tokens are valid
      if (newTokens.accessToken == null ||
          newTokens.accessToken!.isEmpty ||
          newTokens.refreshToken == null ||
          newTokens.refreshToken!.isEmpty) {
        throw Exception('Received invalid tokens from server');
      }

      // Store the new tokens
      await secureStorage.write(
          key: accessTokenKey, value: newTokens.accessToken ?? '');
      await secureStorage.write(
          key: refreshTokenKey, value: newTokens.refreshToken ?? '');

      debugPrint('New tokens stored successfully');

      return newTokens;
    } catch (e) {
      debugPrint('Error refreshing token: $e');
      // Clear tokens on failure
      await secureStorage.deleteAll();
      rethrow;
    }
  }
}




// import 'package:collabry/core/functions/extensions.dart';
// import 'package:collabry/core/utils/app_constants.dart';
// import 'package:collabry/core/utils/singleton.dart';
// import 'package:collabry/features/authentication/repository/auth_repository.dart';
// import 'package:dio/dio.dart';

// class HeaderInterceptor extends Interceptor {
//   final BaseAuthRepository authRepo;
//   final Dio dio;

//   String accessToken = secureStorage.read(key: accessTokenKey).toString();

//   HeaderInterceptor({required this.authRepo, required this.dio});
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers['Authorization'] =
//         'Bearer ${!accessToken.isNullOrEmpty() ? accessToken : null}';
//     super.onRequest(options, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     super.onError(err, handler);
//     if (err.response?.statusCode == 401) {
//       // Attempt to refresh the token
//       final refreshToken = await secureStorage.read(key: refreshTokenKey);
//       if (refreshToken != null) {
//         final newTokens = await authRepo.refreshTokenFun(refreshToken);

//         // Update the token in the request headers
//         err.requestOptions.headers['Authorization'] =
//             'Bearer ${newTokens.accessToken}';

//         // Retry the original request with the new token
//         final response = await dio.fetch(err.requestOptions);
//         return handler.resolve(response);
//       }
//     }

//     // Pass other errors to the next handler
//     return handler.next(err);
//   }
// }

