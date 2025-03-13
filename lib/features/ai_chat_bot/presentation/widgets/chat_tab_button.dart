import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatTabButton extends StatefulWidget {
  const ChatTabButton(
      {super.key,
      required this.pageCondition,
      required this.pageController,
      required this.index,
      required this.text,
      required this.icon});
  final bool pageCondition;
  final PageController pageController;
  final int index;
  final String text;
  final IconData icon;

  @override
  State<ChatTabButton> createState() => _ChatTabButtonState();
}

class _ChatTabButtonState extends State<ChatTabButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.pageController.animateToPage(widget.index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: widget.pageCondition
              ? AppColors.selectedColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(widget.icon),
            Text(
              widget.text,
              style: widget.pageCondition
                  ? AppTextStyles.belanosimaSize12White
                  : AppTextStyles.belanosimaSize12White
                      .copyWith(color: AppColors.selectedColor),
            )
          ],
        ),
      ),
    );
  }
}
