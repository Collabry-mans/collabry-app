import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/Auth_interceptor.dart';
import 'package:collabry/core/errors/exception_handling.dart';
import 'package:dio/dio.dart';

class DioConsumer {
  final Dio dio = Dio();

  DioConsumer() {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(
      LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
          responseHeader: true,
          requestHeader: true),
    );
    dio.interceptors.add(AuthInterceptor(dio));
  }
  Future get(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.get(
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
      final Response<Map<String, dynamic>> response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
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
}
