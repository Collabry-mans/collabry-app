import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommunityTile extends StatelessWidget {
  const CommunityTile({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          buildCommunityName(name),
          const Divider(height: 1, indent: 5, endIndent: 5),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 15, 30, 10),
            child: Column(
              children: [
                //* Community content #1
                CommunityContent(
                  image: Assets.imagesProfileAvatar,
                  title: 'Announcement',
                  text: 'Welcome to the community',
                  time: 'yesterday',
                ),
                SizedBox(height: 5),
                //* Community content #2
                CommunityContent(
                  image: Assets.imagesProfileAvatar,
                  title: 'Announcement',
                  text: 'Welcome to the community',
                  time: 'yesterday',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommunityName(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //* Community name
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Assets.imagesProfileAvatar,
              height: 45,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Text(name, style: AppTextStyles.belanosimaSize12Black),
        ],
      ),
    );
  }
}

class CommunityContent extends StatelessWidget {
  const CommunityContent({
    super.key,
    required this.image,
    required this.title,
    required this.text,
    required this.time,
  });
  final String image, title, text, time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            image,
            height: 35,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.belanosimaSize12Black,
            ),
            Text(
              text,
              style: AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 8),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Text(time,
            style: AppTextStyles.belanosimaSize12Black
                .copyWith(color: AppColors.txtColor)),
      ],
    );
  }
}
