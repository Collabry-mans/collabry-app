import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      height: 60,
      backgroundColor: AppColors.whiteColor,
      color: AppColors.txtColor,
      activeColor: AppColors.oAuthColor,
      onTap: (int index) {},
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
            backgroundColor: AppColors.selectedColor,
            activeBackgroundColor: AppColors.oAuthBorderColor,
            icon: Icons.add,
            activeIcon: Icons.close,
            foregroundColor: AppColors.whiteColor,
            activeForegroundColor: AppColors.whiteColor,
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
              ),
            ],
          ),
        ),
        TabItem(
          icon: Image.asset(Assets.imagesCommunityUnselected),
          activeIcon: Image.asset(Assets.imagesCommunitySelected),
          title: AppStrings.community,
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
