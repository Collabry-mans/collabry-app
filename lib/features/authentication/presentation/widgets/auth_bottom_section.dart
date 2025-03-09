import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/authentication/presentation/widgets/o_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthBottomSection extends StatelessWidget {
  const AuthBottomSection(
      {super.key,
      required this.title,
      required this.text,
      required this.textButtonTxt});
  final String title, text, textButtonTxt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
                child: Divider(color: AppColors.txtColor, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.txtColor,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.txtColor, thickness: 1),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            OAuthButtons(icon: FontAwesomeIcons.facebookF),
            SizedBox(width: 10),
            OAuthButtons(icon: FontAwesomeIcons.google),
            SizedBox(width: 10),
            OAuthButtons(icon: FontAwesomeIcons.apple),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$text ',
              style: AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 12),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, signUpScreen),
              child: Text(
                textButtonTxt,
                style: AppTextStyles.belanosimaSize24W600Purple.copyWith(
                  fontSize: 12,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
