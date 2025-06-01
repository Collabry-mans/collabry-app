import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  const EditableField(
      {super.key,
      required this.label,
      required this.controller,
      required this.isEditing,
      this.prefixText,
      this.maxLines = 1});
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final String? prefixText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: isEditing,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            hintText: 'Enter your $label',
            hintStyle: AppTextStyles.belanosimaSize14Grey,
            border: outLineInputBorder(5),
            prefixText: prefixText,
          ),
          style: AppTextStyles.belanosimaSize14Grey,
        ),
      ],
    );
  }
}
