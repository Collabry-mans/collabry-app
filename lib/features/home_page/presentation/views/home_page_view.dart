import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_app_bar.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const CustomAppBar(),
        drawer: const Drawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomSearch(),
                  ),
                  Text(
                    AppStrings.topics,
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(color: AppColors.headerColor),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 5, 0, 5),
              height: 35,
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: AppColors.selectedColor),
                  child: Center(
                    child: Text(
                      'Topicccccc$index',
                      style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 15,
                          fontFamily: fontBelanosima),
                    ),
                  ),
                ),
                itemCount: 8,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  height: 100,
                  color: Colors.red,
                  margin: const EdgeInsets.all(5),
                ),
                itemCount: 8,
              ),
            )
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: AppColors.whiteColor,
          items: [
            TabItem(
              icon: Image.asset(Assets.imagesHomeUnselected),
              title: 'Home',
              activeIcon: Image.asset(Assets.imagesHomeSelected),
            ),
            TabItem(
              icon: Image.asset(Assets.imagesChatBotUnselected),
              title: 'ChatBot',
              fontFamily: fontBelanosima,
              activeIcon: Image.asset(Assets.imagesChatBotSelected),
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
              title: 'Zash',
              activeIcon: Image.asset(Assets.imagesCommunitySelected),
            ),
            TabItem(
              icon: Image.asset(Assets.imagesLiveUnselected),
              title: 'Zash',
              activeIcon: Image.asset(Assets.imagesLiveSelected),
            ),
          ],
          onTap: (int i) => print('click index=$i'),
          style: TabStyle.fixedCircle,
        ),
      ),
    );
  }
}
