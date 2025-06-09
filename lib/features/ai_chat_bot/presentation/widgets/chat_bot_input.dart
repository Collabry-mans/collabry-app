import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBotInput extends StatelessWidget {
  const ChatBotInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Microphone Button
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary, // Purple background
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.mic, color: Colors.white),
            onPressed: () {
              // Handle microphone tap
            },
          ),
        ),
        const SizedBox(width: 8),

        // Text Input Field with Icon
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.add_a_photo_outlined),
                  color: AppColors.primary,
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.primary,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
