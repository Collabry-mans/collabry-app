import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/core/singleton/singleton.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final String userName = userBox?.get(kUserName) ?? '';
  final String userEmail = userBox?.get(kUserEmail) ?? '';
  final String userAvatar = userBox?.get(kUserAvatar) ?? '';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    if (cubit.state is! UserProfileAvatarLoadedState) {
      context.read<UserProfileCubit>().getUserProfile();
    }
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: ProfileImage(image: userAvatar),
            title: Text(
              userName,
              style: AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            subtitle:
                Text(userEmail, style: AppTextStyles.belanosimaSize14Grey),
          ),
          const Divider(height: 1),
          _buildMenuItem(
            icon: Icons.account_circle_outlined,
            title: AppStrings.viewProfile,
            onTap: () {
              Navigator.pushNamed(context, Routes.userProfileScreen);
            },
          ),

          _buildMenuItem(
            icon: Icons.people_outline,
            title: AppStrings.myCommunity,
            onTap: () {},
          ),

          _buildMenuItem(
            icon: Icons.bookmark_border,
            title: AppStrings.savedPosts,
            onTap: () {},
          ),

          const Divider(height: 1),

          // Settings Items
          _buildMenuItem(
            icon: Icons.dark_mode_outlined,
            title: AppStrings.darkMode,
            onTap: () {},
            trailing: Switch(
              value: false,
              onChanged: (value) {
                value = !value;
              },
            ),
          ),

          _buildMenuItem(
            icon: Icons.help_outline,
            title: AppStrings.helpCenter,
            onTap: () {},
          ),

          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: AppStrings.settings,
            onTap: () {},
          ),

          const Expanded(child: SizedBox()),

          const Divider(height: 1),

          // Logout Button
          _buildMenuItem(
            icon: Icons.logout_outlined,
            title: AppStrings.logout,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await secureStorage.deleteAll().then((_) {
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.logInScreen);
                            }
                          });
                        },
                        child: const Text(AppStrings.logout),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      minLeadingWidth: 20,
    );
  }
}
