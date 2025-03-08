import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/o_auth_buttons.dart';
import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Divider(color: AppColors.txtColor, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.orLoginWith,
                style: TextStyle(
                  color: AppColors.txtColor,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: AppColors.txtColor, thickness: 1),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OAuthButtons(icon: Icons.facebook),
            SizedBox(width: 10),
            OAuthButtons(icon: Icons.verified_user),
            SizedBox(width: 10),
            OAuthButtons(icon: Icons.apple),
          ],
        ),
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.dontHaveAnAccount,
                  style:
                      AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 16),
                ),
                TextSpan(
                  text: AppStrings.signUp,
                  style: AppTextStyles.belanosimaSize24W600Purple.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
