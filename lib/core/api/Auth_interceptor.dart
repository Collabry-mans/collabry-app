// ignore_for_file: file_names
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/features/authentication/model/refresh_token_model.dart';
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
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if ((err.response?.statusCode == 401 || err.response?.statusCode == 500) &&
        !_isRefreshing) {
      final originalRequest = err.requestOptions;
      _isRefreshing = true;

      try {
        final refreshToken = await secureStorage.read(key: refreshTokenKey);

        if (refreshToken != null && refreshToken.isNotEmpty) {
          final RefreshTokenRepository refreshRepo =
              RefreshTokenRepository(dio);
          final newTokens = await refreshRepo.refreshToken(refreshToken);
          debugPrint(
              '${newTokens.refreshToken} is the refresh token and the access token is ${newTokens.accessToken}');
          originalRequest.headers['Authorization'] =
              'Bearer ${newTokens.accessToken}';

          final response = await dio.fetch(originalRequest);
          _isRefreshing = false;
          return handler.resolve(response);
        }
      } catch (e) {
        _isRefreshing = false;
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
    final response = await dio.post(
      EndPoints.refreshToken,
      data: {
        ApiKeys.refreshToken: refreshToken,
      },
    );

    final newTokens = RefreshTokenModel.fromJson(response.data);
    debugPrint(
        '22222222 ${newTokens.refreshToken} is the refresh token and the access token is ${newTokens.accessToken}');

    await secureStorage.write(
        key: accessTokenKey, value: newTokens.accessToken);
    await secureStorage.write(
        key: refreshTokenKey, value: newTokens.refreshToken);
    debugPrint(
        '333333333 ${newTokens.refreshToken} is the refresh token and the access token is ${newTokens.accessToken}');

    return newTokens;
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

