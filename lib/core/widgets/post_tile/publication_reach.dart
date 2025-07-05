import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PublicationReach extends StatelessWidget {
  const PublicationReach({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '2 likes . 0 comments',
          style: AppTextStyles.belanosimaSize14,
        ),
        Text(
          '0 Shares',
          style: AppTextStyles.belanosimaSize14,
        ),
      ],
    );
  }
}
