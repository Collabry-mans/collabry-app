import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(Assets.imagesChatAI,
                  height: MediaQuery.sizeOf(context).width / 2),
              Text('Hello Zash!',
                  style: AppTextStyles.belanosimaSize24W600Purple
                      .copyWith(color: AppColors.headerColor)),
              const Text(AppStrings.howCanIHelpU,
                  style: AppTextStyles.belanosimaSize14Grey)
            ],
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) => const ChatBubble(),
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        )
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '“What are the trending topics among researchers and writers, and can you share related discussions or events?”',
        style: AppTextStyles.belanosimaSize12White
            .copyWith(color: AppColors.onBoardinTxtColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
