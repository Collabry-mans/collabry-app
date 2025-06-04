import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/core/api/networking/local_statuscode.dart';
import 'package:flutter/material.dart';

class ApiErrorModel {
  final String message;
  final String? errorMsg;
  final IconData icon;
  final int statusCode;
  final bool isLastPage;

  ApiErrorModel({
    required this.message,
    this.errorMsg,
    required this.icon,
    required this.statusCode,
    this.isLastPage = false,
  });

  // Factory for default error
  factory ApiErrorModel.defaultError() {
    return ApiErrorModel(
      message: 'Something went wrong. Try again later',
      icon: Icons.error,
      statusCode: LocalStatuscode.defaultError,
    );
  }

  // Factory to parse API response errors
  factory ApiErrorModel.fromApiResponse(
      Map<String, dynamic> json, int statusCode) {
    return ApiErrorModel(
      message:
          getFormattedMessage(json[ApiKeys.message]) ?? 'Server error occurred',
      errorMsg: json[ApiKeys.error] as String?,
      icon: Icons.warning,
      statusCode: statusCode,
      isLastPage: false,
    );
  }

  static String? getFormattedMessage(dynamic message) {
    if (message is List) {
      return (message).join(', ');
    }
    return message.toString();
  }
}
