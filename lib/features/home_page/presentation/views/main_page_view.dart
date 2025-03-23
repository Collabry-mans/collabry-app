import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/features/ai_chat_bot/presentation/views/chat_bot_view.dart';
import 'package:collabry/features/community/presentation/views/community_view.dart';
import 'package:collabry/features/home_page/presentation/views/home_page_view.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_app_bar.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  PageController mainPageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.homeBgColor,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: mainPageController,
                onPageChanged: (index) => setState(() => currentIndex = index),
                children: const [
                  HomePageView(),
                  ChatBotView(),
                  CommunityView(),
                  ChatBotView(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(pageController: mainPageController),
      ),
    );
  }
}
