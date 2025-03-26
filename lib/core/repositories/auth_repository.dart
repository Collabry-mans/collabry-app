import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/authentication/model/log_in_model.dart';
import 'package:collabry/features/authentication/model/sign_up_model.dart';

abstract class BaseAuthRepository {
  Future<SignUpModel> signUp(String name, String email, String pass);
  Future<LogInModel> logIn(String email, String pass);
  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String email, String otpCode);
}

class AuthRepository implements BaseAuthRepository {
  final DioConsumer dio;

  AuthRepository({required this.dio});

  @override
  Future<SignUpModel> signUp(
    String name,
    String email,
    String pass,
  ) async {
    final response = await dio.post(EndPoints.signUP, data: {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.password: pass,
    });
    final user = SignUpModel.fromJson(response);

    return user;
  }

  @override
  Future<LogInModel> logIn(String email, String pass) async {
    final response = await dio.post(EndPoints.logIn, data: {
      ApiKeys.email: email,
      ApiKeys.password: pass,
    });
    final user = LogInModel.fromJson(response);
    return user;
  }

  @override
  Future<void> sendOtp(String email) async {
    await dio.post(EndPoints.sendOtp, data: {ApiKeys.email: email});
  }

  @override
  Future<void> verifyOtp(String email, String otpCode) async {
    await dio.post(EndPoints.verifyOtp,
        data: {ApiKeys.email: email, ApiKeys.otp: otpCode});
  }
}
