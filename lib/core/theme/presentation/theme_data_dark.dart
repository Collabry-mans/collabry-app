import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkThemePrimary,
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.darkThemePrimary),
    cardColor: AppColors.lightGray,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.secondary,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkThemePrimary),
    iconTheme: IconThemeData(color: AppColors.iconsDark),
  );
}
