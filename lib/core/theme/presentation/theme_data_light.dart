import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.homeBackground,
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.white),
    cardColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: AppColors.iconsLight),
    appBarTheme: AppBarTheme(color: AppColors.homeBackground),
  );
}
