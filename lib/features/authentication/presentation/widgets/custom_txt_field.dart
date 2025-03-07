import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTxtField extends StatelessWidget {
  const CustomTxtField({
    super.key,
    required this.text,
    required this.icon,
    required this.textColor,
    required this.iconColor,
  });
  final String text;
  final IconData icon;
  final Color textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.textFieldBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder: outLineInputBorder(),
          focusedBorder: outLineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: AppColors.whiteColor,
      ),
    );
  }
}
