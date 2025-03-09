import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomTxtField(
          text: AppStrings.email,
          icon: Icons.mail_outlined,
          color: AppColors.txtColor,
        ),
        const SizedBox(height: 10),
        const CustomTxtField(
          text: AppStrings.pass,
          icon: FontAwesomeIcons.lock,
          color: AppColors.txtColor,
          isPass: true,
        ),
        CustomCheckBox(
          text: const Text(
            AppStrings.rememberMe,
            style: AppTextStyles.belanosimaSize14Grey,
          ),
          textButton: true,
          textButtonText: AppStrings.forgotPassword,
          onPressed: () => Navigator.pushNamed(context, forgotPasswordScreen),
        ),
      ],
    );
  }
}
