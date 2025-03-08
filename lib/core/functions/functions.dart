import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

OutlineInputBorder outLineInputBorder(double radius) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: const BorderSide(color: AppColors.whiteColor),
  );
}
