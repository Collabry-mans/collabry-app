import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.homeBgColor,
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Assets.imagesProfileAvatar,
                fit: BoxFit.contain,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.selectedColor,
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.selectedColor,
          ),
          child: const Icon(
            Icons.chat,
            color: AppColors.whiteColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.selectedColor,
          ),
          child: const Icon(Icons.notifications, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
