import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/model/sign_up_model.dart';
import 'package:collabry/main.dart';

class AuthRepository {
  final DioConsumer dio;

  AuthRepository({required this.dio});

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
    secureStorage().write(key: accessTokenKey, value: user.accessToken);
    secureStorage().write(key: refreshTokenKey, value: user.refreshToken);
    return user;
  }

  Future<void> signupVerificationEmail(
    String email,
  ) async {
    await dio.post(EndPoints.verificationEmail, data: {
      ApiKeys.email: email,
    });
  }
}
