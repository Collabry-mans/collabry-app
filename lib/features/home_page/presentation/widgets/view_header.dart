import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: AppColors.headerColor, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {},
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
