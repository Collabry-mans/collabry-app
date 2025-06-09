import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomizedAppBar extends StatelessWidget {
  const CustomizedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            const Icon(Icons.arrow_back, color: AppColors.primary),
            Text(
              AppStrings.backToLogin,
              style:
                  AppTextStyles.belanosimaSize16Purple.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
