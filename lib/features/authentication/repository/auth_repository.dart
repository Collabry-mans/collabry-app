import 'package:collabry/core/api/dio_consumer.dart';
import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/local%20storage/secure_storage.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/model/log_in_model.dart';
import 'package:collabry/features/authentication/model/sign_up_model.dart';

abstract class BaseAuthRepository {
  Future<SignUpModel> signUp(String name, String email, String pass);
  Future<LogInModel> logIn(String email, String pass);
}

class AuthRepository implements BaseAuthRepository {
  final DioConsumer dio;
  final SecureStorageService secureStorage;

  AuthRepository(this.secureStorage, {required this.dio});

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
    secureStorage.write(key: accessTokenKey, value: user.accessToken);
    secureStorage.write(key: refreshTokenKey, value: user.refreshToken);
    return user;
  }

  @override
  Future<LogInModel> logIn(String email, String pass) async {
    final Map<String, dynamic> response =
        await dio.post(EndPoints.logIn, data: {
      ApiKeys.email: email,
      ApiKeys.password: pass,
    });
    final user = LogInModel.fromJson(response);
    secureStorage.write(key: accessTokenKey, value: user.accessToken);
    secureStorage.write(key: refreshTokenKey, value: user.refreshToken);
    return user;
  }
}
