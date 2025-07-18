import 'package:collabry/core/functions/extensions/string_extension.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class FieldsWrapper extends StatelessWidget {
  const FieldsWrapper({
    super.key,
    this.label,
    required this.child,
  });
  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return !label.isNullOrEmpty()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label!,
                  style: AppTextStyles.belanosimaSize12.copyWith(fontSize: 14)),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: child,
              ),
            ],
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: child,
          );
  }
}

class DropDownField<T> extends StatelessWidget {
  const DropDownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: FieldsWrapper(
        label: label,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<T>(
            borderRadius: BorderRadius.circular(20),
            dropdownColor: AppColors.white,
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
      ),
    );
  }
}

class PTxtField extends StatelessWidget {
  const PTxtField({
    super.key,
    required this.controller,
    this.label,
    required this.hint,
    this.maxLines = 1,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final String? label;
  final String hint;
  final int? maxLines;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FieldsWrapper(
        label: label,
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppTextStyles.belanosimaSize16.copyWith(color: Colors.black54),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.lightGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
