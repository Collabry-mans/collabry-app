import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddSectionButton extends StatelessWidget {
  const AddSectionButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onPressed,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: const Radius.circular(12.0),
            dashPattern: const [10, 5],
            strokeWidth: 2,
            padding: const EdgeInsets.all(10),
            color: AppColors.txtColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppColors.txtColor,
                size: 32,
              ),
              Text(
                AppStrings.addNewGroup,
                style: AppTextStyles.belanosimaSize24W600Purple
                    .copyWith(color: AppColors.txtColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
