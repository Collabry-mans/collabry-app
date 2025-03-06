import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              Assets.imagesOnBoard1,
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 1.5,
            ),
            const Text(
              AppStrings.welcome,
              style: TextStyle(
                color: AppColors.headerColor,
                fontFamily: 'Barlow_header',
                fontSize: 64,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              AppStrings.welcome,
              style: TextStyle(
                color: AppColors.headerColor,
                fontFamily: 'Belanosima_text',
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
