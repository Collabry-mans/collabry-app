import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTxtField extends StatefulWidget {
  const CustomTxtField({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    this.isPass = false,
    this.validationFun,
    required this.txtController,
  });
  final String text;
  final IconData icon;
  final Color color;
  final bool isPass;
  final String? Function(String?)? validationFun;
  final TextEditingController txtController;

  @override
  State<CustomTxtField> createState() => _CustomTxtFieldState();
}

class _CustomTxtFieldState extends State<CustomTxtField> {
  late bool obscure;
  @override
  void initState() {
    super.initState();
    obscure = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.textFieldBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        validator: widget.validationFun,
        obscureText: obscure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: widget.text,
          hintStyle: AppTextStyles.barlowSize14W600Grey,
          prefixIcon: Icon(
            widget.icon,
            color: widget.color,
            size: 30,
          ),
          suffixIcon: widget.isPass
              ? IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const VerticalDivider(
                        color: AppColors.txtColor,
                        thickness: 0.5,
                        width: 1,
                        endIndent: 7,
                        indent: 7,
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => setState(() => obscure = !obscure),
                        child: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.txtColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder: outLineInputBorder(20),
          focusedBorder: outLineInputBorder(20),
        ),
      ),
    );
  }
}
