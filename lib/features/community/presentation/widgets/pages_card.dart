import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PagesCard extends StatefulWidget {
  const PagesCard({super.key});
  @override
  State<PagesCard> createState() => _PagesCardState();
}

class _PagesCardState extends State<PagesCard> {
  bool isFollowed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.fromLTRB(5, 1, 5, 10),
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //* X to close
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 20,
                color: AppColors.txtColor,
              ),
            ),
          ),

          //* page image
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Assets.imagesProfileAvatar,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          //* Page name
          Text(
            'Unity',
            style: AppTextStyles.belanosimaSize14Grey
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          ),

          //* follow / unfollow button
          GestureDetector(
            onTap: () => setState(() => isFollowed = !isFollowed),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 3),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isFollowed
                    ? AppColors.primaryColor
                    : AppColors.selectedColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                    isFollowed ? AppStrings.unFollow : AppStrings.follow,
                    style: AppTextStyles.belanosimaSize12White),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
