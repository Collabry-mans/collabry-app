import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    super.key,
    required this.isSelected,
    required this.angle,
    required this.index,
    required this.pageController,
  });
  final bool isSelected;
  final double angle;
  final int index;
  final PageController pageController;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.pageController.animateToPage(widget.index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        });
      },
      child: Transform.rotate(
        angle: widget.angle,
        child: Container(
          height: 14,
          width: 11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.isSelected
                ? AppColors.selectedColor
                : AppColors.unSelectedPageIndicator,
          ),
        ),
      ),
    );
  }
}
