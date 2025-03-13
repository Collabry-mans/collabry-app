import 'package:collabry/core/cubit/user_cubit.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTxtField(
          txtController: context.read<UserCubit>().registerNameController,
          text: AppStrings.name,
          icon: Icons.account_circle_outlined,
          color: AppColors.txtColor,
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController: context.read<UserCubit>().registerEmailController,
          text: AppStrings.email,
          icon: Icons.email,
          color: AppColors.txtColor,
          validationFun: (String? msg) {
            if (!msg!.contains('@')) {
              return 'The email address should contain @';
            }
            return '';
          },
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController: context.read<UserCubit>().registerPassController,
          text: AppStrings.pass,
          icon: Icons.lock_outline_rounded,
          color: AppColors.txtColor,
          isPass: true,
          validationFun: (String? msg) {
            if (msg!.length > 8) {
              return 'The password should contain more than 8 characters';
            }
            return '';
          },
        ),
        const SizedBox(height: 5),
        CustomTxtField(
          txtController:
              context.read<UserCubit>().registerConfirmPassController,
          isPass: true,
          text: AppStrings.confirmPassword,
          icon: Icons.lock_outline_rounded,
          color: AppColors.txtColor,
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
