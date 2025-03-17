import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatTabButton extends StatefulWidget {
  const ChatTabButton({
    super.key,
    required this.pageCondition,
    required this.pageController,
    required this.index,
    required this.text,
    required this.iconSelected,
    required this.iconUnselected,
  });
  final bool pageCondition;
  final PageController pageController;
  final int index;
  final String text;
  final String iconSelected;
  final String iconUnselected;

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: widget.pageCondition
              ? AppColors.selectedColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
              child: Image.asset(
                widget.pageCondition
                    ? widget.iconSelected
                    : widget.iconUnselected,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 20),
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
