import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.text,
      this.onPressed,
      this.textButton,
      this.textButtonText});
  final Widget text;
  final bool? textButton;
  final String? textButtonText;
  final VoidCallback? onPressed;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              side: const BorderSide(color: AppColors.lightGray, width: 2),
              value: isSelected,
              onChanged: (selectedStatus) =>
                  setState(() => isSelected = selectedStatus ?? false),
            ),
            widget.text
          ],
        ),
        widget.textButton ?? false
            ? TextButton(
                onPressed: widget.onPressed,
                child: Text(
                  widget.textButtonText!,
                  style: AppTextStyles.belanosimaSize16,
                ),
              )
            : Container(),
      ],
    );
  }
}
