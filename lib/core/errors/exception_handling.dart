import 'package:collabry/core/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    //* Network-related errors
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      throw ServerException(
        errModel: ErrorModel(
          message: 'Network error occurred. Please check your connection.',
          errorMsg: e.message ?? 'Network error',
          statusCode: 0,
        ),
      );

    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      throw ServerException(
        errModel: ErrorModel(
          message: e.message ?? 'An unknown error occurred',
          errorMsg: e.error?.toString() ?? 'Unknown error',
          statusCode: 0,
        ),
      );
    case DioExceptionType.badResponse:
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400: // Bad request
          case 401: // unauthorized
          case 403: // forbidden
          case 404: // not found
          case 409: // cofficient
          case 422: // Unprocessable Entity
          case 504: // Server exception
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          default:
            throw ServerException(
              errModel: ErrorModel(
                message: 'Server error occurred',
                errorMsg: e.response?.statusMessage ?? 'Server error',
                statusCode: e.response?.statusCode ?? 500,
              ),
            );
        }
      } else {
        throw ServerException(
          errModel: ErrorModel(
            message: 'No response from server',
            errorMsg: 'Server did not respond',
            statusCode: 0,
          ),
        );
      }
  }
}
