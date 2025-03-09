import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        filled: true,
        fillColor: AppColors.whiteColor,
        enabledBorder: outLineInputBorder(10),
        focusedBorder: outLineInputBorder(10),
        hintText: AppStrings.search,
        hintStyle: AppTextStyles.belanosimaSize14Grey,
        prefixIcon: const Icon(Icons.search, color: AppColors.selectedColor),
        suffixIcon: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic, color: AppColors.selectedColor),
            SizedBox(width: 10),
            Icon(Icons.filter_list, color: AppColors.selectedColor),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
