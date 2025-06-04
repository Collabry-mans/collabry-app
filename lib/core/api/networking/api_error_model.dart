import 'package:collabry/core/api/networking/local_statuscode.dart';
import 'package:flutter/material.dart';

class ApiErrorModel {
  final String message;
  final IconData icon;
  final int statusCode;
  final bool isLastPage;

  ApiErrorModel(
      {required this.message,
      required this.icon,
      required this.statusCode,
      this.isLastPage = false});
  factory ApiErrorModel.defaultError() {
    return ApiErrorModel(
      message: 'Something went wrong. Try again later',
      icon: Icons.error,
      statusCode: LocalStatuscode.defaultError,
    );
  }
}
