import 'package:collabry/core/functions/extensions/theme_extension.dart';
import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/widgets/error_display.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'info_chip.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileHeader({
    super.key,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      buildWhen: (_, curr) =>
          curr is UserProfileLoadedState ||
          curr is UserProfileLoadingState ||
          curr is UserProfileFailedState,
      builder: (context, state) {
        if (state is UserProfileLoadedState) {
          final cubit = context.read<UserProfileCubit>();
          final user = cubit.user!;

          return Container(
            padding: const EdgeInsets.all(20),
            color: context.customColors.bottomNavBarColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileImage(
                      image: user.profile.profileImage,
                      radius: 45,
                    ),
                    GestureDetector(
                      onTap: onEditProfile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Name and Bio
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.profile.bio.isNotEmpty
                            ? user.profile.bio
                            : 'No bio available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.lightGray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // Profile Info
                if (user.profile.expertise.isNotEmpty ||
                    user.profile.languages.isNotEmpty)
                  Column(
                    children: [
                      if (user.profile.expertise.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: user.profile.expertise
                                .take(3)
                                .map((skill) => InfoChip(
                                    icon: Icons.work, text: skill.toString()))
                                .toList(),
                          ),
                        ),
                      if (user.profile.languages.isNotEmpty)
                        const SizedBox(height: 10),
                      if (user.profile.languages.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: user.profile.languages
                                .take(2)
                                .map((language) => InfoChip(
                                    icon: Icons.language,
                                    text: language.toString()))
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                if (user.profile.linkedIn != null &&
                    user.profile.linkedIn!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        openSocialMedia(null, user.profile.linkedIn ?? ''),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InfoChip(
                        icon: Icons.link,
                        text: 'LinkedIn',
                      ),
                    ),
                  )
                ],
                const SizedBox(height: 15),
                // Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserProfileLoadingState) {
          return Container(
            height: 350,
            color: context.customColors.bottomNavBarColor,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        } else if (state is UserProfileFailedState) {
          return Container(
            height: 350,
            color: context.customColors.bottomNavBarColor,
            child: Center(
              child: ErrorDisplay(
                message: state.errModel.message,
                icon: state.errModel.icon,
                onRetry: () {
                  context.read<UserProfileCubit>().getUserProfile();
                },
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
