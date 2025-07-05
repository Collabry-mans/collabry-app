import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/ai_chat_bot/presentation/widgets/chat_bot_bubles.dart';
import 'package:collabry/features/ai_chat_bot/presentation/widgets/chat_bot_input.dart';
import 'package:flutter/material.dart';

class AIGenerateView extends StatefulWidget {
  const AIGenerateView({super.key});

  @override
  State<AIGenerateView> createState() => _AIGenerateViewState();
}

class _AIGenerateViewState extends State<AIGenerateView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(Assets.imagesAIGenerate,
                height: MediaQuery.sizeOf(context).width / 2),
            Text('Hello Zash!',
                style: AppTextStyles.belanosimaSize24W600Purple
                    .copyWith(color: AppColors.appHeader)),
            const Text(AppStrings.howCanIHelpU,
                style: AppTextStyles.belanosimaSize14)
          ],
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => const ChatBotBubble(),
            itemCount: 3,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: ChatBotInput(),
        ),
      ],
    );
  }
}
