import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatBotBubble extends StatelessWidget {
  const ChatBotBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '“What are the trending topics among researchers and writers, and can you share related discussions or events?”',
        style: AppTextStyles.belanosimaSize12White
            .copyWith(color: AppColors.onBoardinTxtColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
