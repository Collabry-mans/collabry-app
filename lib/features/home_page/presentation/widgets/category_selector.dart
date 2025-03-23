import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: AppColors.headerColor, fontSize: 16),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.viewMore,
                style:
                    AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
