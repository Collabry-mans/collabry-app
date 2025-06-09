import 'package:collabry/features/authentication/presentation/manager/auth_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupTextFields extends StatelessWidget {
  const SignupTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTxtField(
          txtController: authCubit.registerNameController,
          text: AppStrings.name,
          icon: Icons.account_circle_outlined,
          color: AppColors.lightGray,
          validationFun: (value) {
            if (value == null || value.isEmpty) {
              return 'U should enter a name';
            }
            return null;
          },
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController: authCubit.registerEmailController,
          text: AppStrings.email,
          icon: Icons.email,
          color: AppColors.lightGray,
          validationFun: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!value.contains('@')) {
              return 'Email should contain @';
            }
            return null;
          },
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController: authCubit.registerPassController,
          text: AppStrings.pass,
          icon: Icons.lock_outline_rounded,
          color: AppColors.lightGray,
          isPass: true,
          validationFun: (String? msg) {
            if (msg == null || msg.isEmpty) {
              return 'Please enter a password';
            } else if (msg.length < 8) {
              return 'The password should contain more than 8 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController: authCubit.registerConfirmPassController,
          isPass: true,
          text: AppStrings.confirmPassword,
          icon: Icons.lock_outline_rounded,
          color: AppColors.lightGray,
          validationFun: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value !=
                context.read<AuthCubit>().registerPassController.text) {
              return 'both passwords should be the same';
            }
            return null;
          },
        ),
        const CustomCheckBox(
          text: Text(
            AppStrings.checkingBoxTerms,
            style: AppTextStyles.belanosimaSize14Grey,
          ),
        ),
      ],
    );
  }
}
