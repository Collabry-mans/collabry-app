import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChannelTile extends StatelessWidget {
  const ChannelTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.fromLTRB(5, 15, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* channel image
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Assets.imagesProfileAvatar,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          //* channel body
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* header and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UI/UX Challenges',
                      style: AppTextStyles.belanosimaSize14
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      'yesterday',
                      style: AppTextStyles.belanosimaSize14
                          .copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
                //* content and isReadOrNot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'The UX design goes through multiple challenges fokdokfokfoskkfspdj k ksfdk fdk[pk[p g[pkr[ ker[k ] ]]]]',
                        style: AppTextStyles.belanosimaSize12White
                            .copyWith(color: AppColors.lightGray),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
