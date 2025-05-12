import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/auth_interceptor.dart';
import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/authentication/data/repository/refresh_token_repository.dart';
import 'package:dio/dio.dart';

class DioConsumer {
  final Dio dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  DioConsumer() {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(AuthInterceptor(
        dio,
        RefreshTokenRepository(
            dio))); // we can use the dio here bcz we are sepearating a new dio without interceptors in the repo itself
    dio.interceptors.add(
      LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
          responseHeader: true,
          requestHeader: true),
    );
  }
  Future get(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final Response response = await dio.get(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final Response response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
