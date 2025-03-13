import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/ai_chat_bot/presentation/views/ai_generate_view.dart';
import 'package:collabry/features/ai_chat_bot/presentation/views/chat_view.dart';
import 'package:collabry/features/ai_chat_bot/presentation/widgets/chat_tab_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  PageController chatBotPageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ChatTabButton(
                    pageCondition: currentIndex == 0,
                    pageController: chatBotPageController,
                    index: 0,
                    text: AppStrings.chatBot,
                    icon: FontAwesomeIcons.circleQuestion,
                  ),
                ),
                Expanded(
                  child: ChatTabButton(
                    pageCondition: currentIndex == 1,
                    pageController: chatBotPageController,
                    index: 1,
                    text: AppStrings.aiGenerate,
                    icon: FontAwesomeIcons.spa,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: chatBotPageController,
              children: const [
                Expanded(child: ChatView()),
                Expanded(child: AIGenerateView()),
              ],
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
