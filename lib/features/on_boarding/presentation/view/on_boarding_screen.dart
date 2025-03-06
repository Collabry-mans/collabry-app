import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/widgets/custom_button.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/on_boarding_item_builder.dart';
import 'package:collabry/features/on_boarding/presentation/widgets/page_indicator_builder.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  int index = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: pageController,
                itemBuilder: (context, index) => OnBoardingItemBuilder(
                    image: boardingScreens[index].image,
                    title: boardingScreens[index].title,
                    text: boardingScreens[index].text),
                itemCount: 4,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageIndicatorBuilder(
                  index: index, pageController: pageController),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () {
                    setState(() {
                      index == 3
                          ? Navigator.pushNamedAndRemoveUntil(
                              context,
                              logInScreen,
                              (route) => false,
                            )
                          : {
                              index++,
                              pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut)
                            };
                    });
                  },
                  text:
                      index == 3 ? AppStrings.getStarted : AppStrings.continue_,
                  icon: Icons.keyboard_arrow_right_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
