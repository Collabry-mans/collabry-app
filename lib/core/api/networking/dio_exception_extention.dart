import 'package:collabry/core/api/networking/api_error_model.dart';
import 'package:dio/dio.dart';

extension DioExceptionTypeExtension on DioException {
  ApiErrorModel when({
    required ApiErrorModel Function() connectionError,
    required ApiErrorModel Function() connectionTimeout,
    required ApiErrorModel Function() sendTimeout,
    required ApiErrorModel Function() receiveTimeout,
    required ApiErrorModel Function() badCertificate,
    required ApiErrorModel Function() badResponse,
    required ApiErrorModel Function() cancel,
    required ApiErrorModel Function() unknown,
  }) {
    switch (type) {
      case DioExceptionType.connectionError:
        return connectionError();
      case DioExceptionType.connectionTimeout:
        return connectionTimeout();
      case DioExceptionType.sendTimeout:
        return sendTimeout();
      case DioExceptionType.receiveTimeout:
        return receiveTimeout();
      case DioExceptionType.badCertificate:
        return badCertificate();
      case DioExceptionType.badResponse:
        return badResponse();
      case DioExceptionType.cancel:
        return cancel();
      default:
        return unknown();
    }
  }
}
