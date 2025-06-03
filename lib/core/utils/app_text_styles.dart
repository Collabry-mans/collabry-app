import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle barlowSize52BoldWhite = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 52,
    fontFamily: fontBarlow,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle barlowSize42BoldPurple = TextStyle(
    color: AppColors.selectedColor,
    fontSize: 42,
    fontFamily: fontBarlow,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle barlowSize14W600Grey = TextStyle(
    color: AppColors.txtColor,
    fontSize: 14,
    fontFamily: fontBarlow,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle belanosimaSize12White = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 12,
    fontFamily: fontBelanosima,
  );

  static const TextStyle belanosimaSize16BlackBold = TextStyle(
    color: AppColors.blackColor,
    fontSize: 16,
    fontFamily: fontBelanosima,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle belanosimaSize12Black = TextStyle(
    color: AppColors.blackColor,
    fontSize: 12,
    fontFamily: fontBelanosima,
  );

  static const TextStyle belanosimaSize24W600Purple = TextStyle(
    color: AppColors.selectedColor,
    fontSize: 24,
    fontFamily: fontBelanosima,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle belanosimaSize14Grey = TextStyle(
    color: AppColors.txtColor,
    fontFamily: fontBelanosima,
    fontSize: 14,
  );
  static const TextStyle belanosimaSize16Purple = TextStyle(
    color: AppColors.selectedColor,
    fontFamily: fontBelanosima,
    fontSize: 16,
  );

  static const TextStyle allertaSize16White = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: 'Allerta_button',
    fontSize: 16,
  );
}
