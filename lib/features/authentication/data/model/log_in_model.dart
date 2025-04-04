import 'package:collabry/core/api/end_points.dart';

class LogInModel {
  final String accessToken;
  final String refreshToken;

  LogInModel({required this.accessToken, required this.refreshToken});
  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
        accessToken: json[ApiKeys.accessToken],
        refreshToken: json[ApiKeys.refreshToken]);
  }
}
