import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnBoardingItemBuilder extends StatelessWidget {
  const OnBoardingItemBuilder(
      {super.key,
      required this.image,
      required this.title,
      required this.text});
  final String image, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.appHeader,
              fontFamily: 'Barlow_header',
              fontSize: title == AppStrings.unlimitedCollaboration ? 40 : 48,
              fontWeight: FontWeight.w900,
              height: 0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            text,
            style: AppTextStyles.belanosimaSize16Purple
                .copyWith(color: AppColors.onBoardingText),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
