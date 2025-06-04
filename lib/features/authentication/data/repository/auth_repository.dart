import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/networking/api_error_handler.dart';
import 'package:collabry/core/api/networking/api_result.dart';
import 'package:collabry/features/authentication/data/model/log_in_model.dart';
import 'package:collabry/features/authentication/data/model/sign_up_model.dart';

abstract class BaseAuthRepository {
  Future<ApiResult<SignUpModel>> signUp(String name, String email, String pass);
  Future<ApiResult<LogInModel>> logIn(String email, String pass);
  Future<ApiResult<void>> sendOtp(String email);
  Future<ApiResult<void>> verifyOtp(String email, String otpCode);
}

class AuthRepository implements BaseAuthRepository {
  final DioConsumer dio;

  AuthRepository({required this.dio});

  @override
  Future<ApiResult<SignUpModel>> signUp(
    String name,
    String email,
    String pass,
  ) async {
    try {
      final response = await dio.post(EndPoints.signUP, data: {
        ApiKeys.name: name,
        ApiKeys.email: email,
        ApiKeys.password: pass,
      });
      final user = SignUpModel.fromJson(response);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<LogInModel>> logIn(String email, String pass) async {
    try {
      final response = await dio.post(EndPoints.logIn, data: {
        ApiKeys.email: email,
        ApiKeys.password: pass,
      });
      final user = LogInModel.fromJson(response);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> sendOtp(String email) async {
    try {
      await dio.post(EndPoints.sendOtp, data: {ApiKeys.email: email});
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> verifyOtp(String email, String otpCode) async {
    try {
      await dio.post(EndPoints.verifyOtp,
          data: {ApiKeys.email: email, ApiKeys.otp: otpCode});
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
