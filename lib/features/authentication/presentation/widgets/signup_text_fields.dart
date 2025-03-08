import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';

class SignupTextFields extends StatelessWidget {
  const SignupTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTxtField(
          text: AppStrings.name,
          icon: Icons.account_circle_outlined,
          color: AppColors.txtColor,
        ),
        SizedBox(height: 5),
        CustomTxtField(
          text: AppStrings.email,
          icon: Icons.email,
          color: AppColors.txtColor,
        ),
        SizedBox(height: 5),
        CustomTxtField(
          text: AppStrings.pass,
          icon: Icons.lock_outline_rounded,
          color: AppColors.txtColor,
          isPass: true,
        ),
        SizedBox(height: 5),
        CustomTxtField(
          text: AppStrings.confirmPassword,
          icon: Icons.lock_outline_rounded,
          color: AppColors.txtColor,
          isPass: true,
        ),
        CustomCheckBox(
          text: Text(
            AppStrings.checkingBoxTerms,
            style: AppTextStyles.belanosimaSize14Grey,
          ),
        ),
      ],
    );
  }
}
