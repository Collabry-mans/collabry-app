import 'package:another_flushbar/flushbar.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FlushBarUtils {
  static void flushBarError(String errorMessage, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: errorMessage,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: AppColors.secondary,
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: AppColors.secondary,
    ).show(context);
  }

  static void flushBarSuccess(String successMsg, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarStyle: FlushbarStyle.FLOATING,
      message: successMsg,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: AppColors.successedColor,
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: AppColors.secondary,
    ).show(context);
  }

  static void flushBarMsg(String msg, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarStyle: FlushbarStyle.FLOATING,
      message: msg,
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: AppColors.secondary,
    ).show(context);
  }
}
