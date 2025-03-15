import 'package:collabry/core/api/end_points.dart';

class RefreshTokenModel {
  final String refreshToken, accessToken;

  RefreshTokenModel({required this.refreshToken, required this.accessToken});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
        refreshToken: json[ApiKeys.refreshToken],
        accessToken: json[ApiKeys.accessToken]);
  }
}
