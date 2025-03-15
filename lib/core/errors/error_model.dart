import 'package:collabry/core/api/end_points.dart';

class ErrorModel {
  final dynamic message;
  final String errorMsg;
  final int statusCode;

  ErrorModel(
      {required this.message,
      required this.errorMsg,
      required this.statusCode});

  String getFormattedMessage() {
    if (message is List) {
      return (message as List).join(', ');
    }
    return message.toString();
  }

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json[ApiKeys.message],
      errorMsg: json[ApiKeys.error],
      statusCode: json[ApiKeys.statusCode],
    );
  }
}
