import 'package:collabry/core/cubit/auth_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTxtField(
          txtController: authCubit.logInEmailController,
          text: AppStrings.email,
          icon: Icons.mail_outlined,
          color: AppColors.txtColor,
          validationFun: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        CustomTxtField(
          txtController: authCubit.logInPassController,
          text: AppStrings.pass,
          icon: FontAwesomeIcons.lock,
          color: AppColors.txtColor,
          isPass: true,
          validationFun: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
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
