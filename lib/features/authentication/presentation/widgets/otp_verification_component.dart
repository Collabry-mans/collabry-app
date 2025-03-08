import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OTPVerificationComponent extends StatelessWidget {
  const OTPVerificationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 58,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.textFieldBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder: outLineInputBorder(5),
          focusedBorder: outLineInputBorder(5),
        ),
      ),
    );
  }
}
