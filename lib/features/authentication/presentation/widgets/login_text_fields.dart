import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/custom_txt_field.dart';
import 'package:flutter/material.dart';

class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  bool isSelected = false;

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
          icon: Icons.lock_outlined,
          color: AppColors.txtColor,
          isPass: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  side: const BorderSide(
                    color: AppColors.txtColor,
                    width: 2,
                  ),
                  value: isSelected,
                  onChanged: (selectedStatus) =>
                      setState(() => isSelected = selectedStatus ?? false),
                ),
                const Text(
                  AppStrings.rememberMe,
                  style: AppTextStyles.belanosimaSize14Grey,
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                AppStrings.forgotPassword,
                style: AppTextStyles.belanosimaSize16Purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
