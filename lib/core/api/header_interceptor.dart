import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/authentication/model/refresh_token_model.dart';
import 'package:dio/dio.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/singleton.dart';

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
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refreshToken = await secureStorage.read(key: refreshTokenKey);

        if (refreshToken != null && refreshToken.isNotEmpty) {
          // Create a new instance of Dio to avoid circular dependencies
          final tempDio = Dio()..options.baseUrl = dio.options.baseUrl;

          // Create a minimal repository just for token refresh
          final refreshRepo = RefreshTokenRepository(tempDio);

          // Get new tokens
          final newTokens = await refreshRepo.refreshToken(refreshToken);

          // Update the original request with new token and retry
          final originalRequest = err.requestOptions;
          originalRequest.headers['Authorization'] =
              'Bearer ${newTokens.accessToken}';

          // Retry the original request
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

// This is a minimal repository just for token refresh to avoid circular dependencies
class RefreshTokenRepository {
  final Dio dio;

  RefreshTokenRepository(this.dio);

  Future<RefreshTokenModel> refreshToken(String refreshToken) async {
    final response = await dio.post(
      EndPoints.refreshToken, // Assuming this is your refresh token endpoint
      data: {
        ApiKeys.refreshToken: refreshToken,
      },
    );

    final newTokens = RefreshTokenModel.fromJson(response.data);
    await secureStorage.write(
        key: accessTokenKey, value: newTokens.accessToken);
    await secureStorage.write(
        key: refreshTokenKey, value: newTokens.refreshToken);

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

