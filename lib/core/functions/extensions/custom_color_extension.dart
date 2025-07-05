import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors._(
      {required this.secondaryColor, required this.bottomNavBarColor});
  final Color secondaryColor;
  final Color bottomNavBarColor;

  factory CustomColors._light() {
    return const CustomColors._(
        secondaryColor: AppColors.ghostWhite,
        bottomNavBarColor: AppColors.ghostWhite);
  }

  factory CustomColors._dark() {
    return const CustomColors._(
        secondaryColor: AppColors.black,
        bottomNavBarColor: AppColors.darkThemePrimary);
  }
}

extension CustomColorsExtension on ThemeData {
  CustomColors get customColors {
    if (brightness == Brightness.dark) return CustomColors._dark();
    return CustomColors._light();
  }
}
