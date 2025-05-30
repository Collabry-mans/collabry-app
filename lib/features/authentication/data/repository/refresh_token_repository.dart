import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:dio/dio.dart';

class RefreshTokenRepository {
  final Dio dio;
  RefreshTokenRepository(this.dio);

  Future<RefreshTokenModel?> refreshToken(String refreshToken) async {
    try {
      // Create clean dio instance without interceptors
      final tokenDio = Dio(
        BaseOptions(
          baseUrl: dio.options.baseUrl,
          connectTimeout: dio.options.connectTimeout,
          receiveTimeout: dio.options.receiveTimeout,
        ),
      );

      final response = await tokenDio.post(
        EndPoints.refreshToken,
        data: {ApiKeys.refreshToken: refreshToken},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return null;
      }

      final newTokens = RefreshTokenModel.fromJson(response.data);

      // Validate tokens before saving
      if (newTokens.accessToken.isNullOrEmpty() ||
          newTokens.refreshToken.isNullOrEmpty()) {
        return null;
      }

      // Save new tokens
      await Future.wait([
        secureStorage.write(key: accessTokenKey, value: newTokens.accessToken!),
        secureStorage.write(
            key: refreshTokenKey, value: newTokens.refreshToken!),
      ]);

      return newTokens;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 400) {
        await secureStorage.deleteAll();
      }
      return null; // Return null instead of rethrowing
    }
  }
}

class RefreshTokenModel {
  final String? refreshToken, accessToken;

  RefreshTokenModel({required this.refreshToken, required this.accessToken});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
        refreshToken: json[ApiKeys.refreshToken],
        accessToken: json[ApiKeys.accessToken]);
  }
}
