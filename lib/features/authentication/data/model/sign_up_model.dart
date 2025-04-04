import 'package:collabry/core/api/end_points.dart';

class SignUpModel {
  final String accessToken;
  final String refreshToken;

  SignUpModel({
    required this.accessToken,
    required this.refreshToken,
  });
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
        accessToken: json[ApiKeys.accessToken],
        refreshToken: json[ApiKeys.refreshToken]);
  }
}
