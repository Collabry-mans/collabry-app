import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/singleton.dart';
import 'package:collabry/features/authentication/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  final BaseAuthRepository authRepo;
  final Dio dio;

  String accessToken = secureStorage.read(key: accessTokenKey).toString();

  HeaderInterceptor({required this.authRepo, required this.dio});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer ${!accessToken.isNullOrEmpty() ? accessToken : null}';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      // Attempt to refresh the token
      final refreshToken = await secureStorage.read(key: refreshTokenKey);
      if (refreshToken != null) {
        final newTokens = await authRepo.refreshTokenFun(refreshToken);

        // Update the token in the request headers
        err.requestOptions.headers['Authorization'] =
            'Bearer ${newTokens.accessToken}';

        // Retry the original request with the new token
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }

    // Pass other errors to the next handler
    return handler.next(err);
  }
}
