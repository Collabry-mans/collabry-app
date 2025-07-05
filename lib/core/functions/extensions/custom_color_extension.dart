import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors._(
      {required this.secondaryColor,
      required this.bottomNavBarColor,
      required this.purpleTextColor});
  final Color secondaryColor;
  final Color bottomNavBarColor;
  final Color purpleTextColor;

  factory CustomColors._light() {
    return const CustomColors._(
        secondaryColor: AppColors.ghostWhite,
        bottomNavBarColor: AppColors.ghostWhite,
        purpleTextColor: AppColors.primary);
  }

  factory CustomColors._dark() {
    return const CustomColors._(
        secondaryColor: AppColors.black,
        bottomNavBarColor: AppColors.darkThemePrimary,
        purpleTextColor: AppColors.secondary);
  }
}

extension CustomColorsExtension on ThemeData {
  CustomColors get customColors {
    if (brightness == Brightness.dark) return CustomColors._dark();
    return CustomColors._light();
  }
}
