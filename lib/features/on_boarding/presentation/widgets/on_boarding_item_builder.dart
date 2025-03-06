import 'package:collabry/core/utils/app_colors.dart';
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
        Image.asset(
          image,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.5,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.headerColor,
              fontFamily: 'Barlow_header',
              fontSize: 45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.headerColor,
              fontFamily: 'Belanosima_text',
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
