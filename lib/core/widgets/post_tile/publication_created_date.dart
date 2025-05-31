import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PublicationCreatedDate extends StatelessWidget {
  const PublicationCreatedDate({
    super.key,
    required this.createdAt,
  });

  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${createdAt.split('T').first} . ',
          style: AppTextStyles.belanosimaSize14Grey,
        ),
        const Icon(
          Icons.public_outlined,
          size: 16,
          color: AppColors.txtColor,
        ),
      ],
    );
  }
}
