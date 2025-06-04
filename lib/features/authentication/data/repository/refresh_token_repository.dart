import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/data/model/refresh_token_model.dart';
import 'package:dio/dio.dart';

class RefreshTokenRepository {
  RefreshTokenRepository();

  Future<RefreshTokenModel?> refreshToken(String refreshToken) async {
    try {
      // Create clean dio instance without interceptors
      final tokenDio = Dio(
        BaseOptions(baseUrl: EndPoints.baseUrl),
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
      return null;
    }
  }
}
