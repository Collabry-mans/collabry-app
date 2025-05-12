import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/functions/extensions.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/authentication/data/model/refresh_token_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RefreshTokenRepository {
  final Dio dio;
  RefreshTokenRepository(this.dio);

  Future<RefreshTokenModel?> refreshToken(String refreshToken) async {
    try {
      // Create a new Dio instance without interceptors to avoid loops
      final tokenDio = Dio(BaseOptions(
        baseUrl: dio.options.baseUrl,
        connectTimeout: dio.options.connectTimeout,
        receiveTimeout: dio.options.receiveTimeout,
      ));

      final Response response = await tokenDio.post(
        EndPoints.refreshToken,
        data: {EndPoints.refreshToken: refreshToken},
      );

      debugPrint('Refresh token response status: ${response.statusCode}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        return null;
      }

      final newTokens = RefreshTokenModel.fromJson(response.data);

      if (newTokens.accessToken.isNullOrEmpty() ||
          newTokens.refreshToken.isNullOrEmpty()) {
        debugPrint('Received invalid tokens from server');
        return null;
      }

      await secureStorage.write(
          key: accessTokenKey, value: newTokens.accessToken!);
      await secureStorage.write(
          key: refreshTokenKey, value: newTokens.refreshToken!);

      debugPrint('New tokens stored successfully');

      return newTokens;
    } catch (e) {
      debugPrint('Error refreshing token: $e');
      await secureStorage.deleteAll();
      rethrow;
    }
  }
}
