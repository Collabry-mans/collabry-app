import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';

class SignupTextFields extends StatefulWidget {
  const SignupTextFields(
      {super.key, required this.name, required this.email, required this.pass});
  final TextEditingController name, email, pass;

  @override
  State<SignupTextFields> createState() => _SignupTextFieldsState();
}

class _SignupTextFieldsState extends State<SignupTextFields> {
  late TextEditingController confirmPassController;

  @override
  void initState() {
    super.initState();
    confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTxtField(
          txtController: widget.name,
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
          txtController: widget.email,
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
          txtController: widget.pass,
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
          txtController: confirmPassController,
          isPass: true,
          text: AppStrings.confirmPassword,
          icon: Icons.lock_outline_rounded,
          color: AppColors.lightGray,
          validationFun: (value) {
            if (value != widget.pass.text) {
              return 'both passwords should be the same';
            }
            return null;
          },
        ),
        const CustomCheckBox(
          text: Text(
            AppStrings.checkingBoxTerms,
            style: AppTextStyles.belanosimaSize14,
          ),
        ),
      ],
    );
  }
}
