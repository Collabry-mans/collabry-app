import 'package:collabry/features/on_boarding/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

class PageIndicatorBuilder extends StatelessWidget {
  const PageIndicatorBuilder(
      {super.key, required this.index, required this.pageController});
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PageIndicator(
              index: 0,
              angle: 0.3,
              isSelected: index == 0,
              pageController: pageController),
          const SizedBox(width: 24),
          PageIndicator(
              index: 1,
              isSelected: index == 1,
              angle: -0.2,
              pageController: pageController),
          const SizedBox(width: 24),
          PageIndicator(
              index: 2,
              isSelected: index == 2,
              angle: 0.3,
              pageController: pageController),
          const SizedBox(width: 24),
          PageIndicator(
              index: 3,
              isSelected: index == 3,
              angle: -0.2,
              pageController: pageController),
        ],
      ),
    );
  }
}
