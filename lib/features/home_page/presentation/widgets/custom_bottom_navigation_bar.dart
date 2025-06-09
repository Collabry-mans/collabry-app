import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.pageController,
    required this.index,
  });
  final PageController pageController;
  final int index;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: widget.index,
      height: 60,
      backgroundColor: AppColors.white,
      color: AppColors.lightGray,
      activeColor: AppColors.oAuth,
      onTap: (int index) {
        widget.pageController.animateToPage(index >= 2 ? index - 1 : index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      },
      style: TabStyle.fixedCircle,
      items: [
        TabItem(
          icon: Image.asset(Assets.imagesHomeUnselected),
          activeIcon: Image.asset(Assets.imagesHomeSelected),
          title: AppStrings.home,
        ),
        TabItem(
          icon: Image.asset(Assets.imagesChatBotUnselected),
          activeIcon: Image.asset(Assets.imagesChatBotSelected),
          title: AppStrings.chatBot,
        ),
        TabItem(
          icon: SpeedDial(
            gradientBoxShape: BoxShape.circle,
            overlayOpacity: 0.4,
            backgroundColor: AppColors.primary,
            activeBackgroundColor: AppColors.oAuthBorder,
            icon: Icons.add,
            activeIcon: Icons.close,
            foregroundColor: AppColors.white,
            activeForegroundColor: AppColors.white,
            children: [
              SpeedDialChild(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const CircleAvatar(
                  child: Icon(Icons.video_call),
                ),
              ),
              SpeedDialChild(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const CircleAvatar(
                  child: Icon(Icons.live_tv),
                ),
              ),
              SpeedDialChild(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const CircleAvatar(
                  child: Icon(Icons.edit),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.createPublicationScreen);
                },
              ),
            ],
          ),
        ),
        TabItem(
          icon: Image.asset(Assets.imagesCommunityUnselected),
          activeIcon: Image.asset(Assets.imagesCommunitySelected),
          title: AppStrings.communities,
        ),
        TabItem(
          icon: Image.asset(Assets.imagesLiveUnselected),
          activeIcon: Image.asset(Assets.imagesLiveSelected),
          title: AppStrings.live,
        ),
      ],
    );
  }
}
