import 'package:collabry/core/theme/cubit/theme_cubit.dart';
import 'package:collabry/features/home_page/presentation/widgets/drawer_menu_item.dart';
import 'package:collabry/features/home_page/presentation/widgets/logout_alert_dialog.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
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
  final String userName = userBox?.get(HiveKeys.kUserName) ?? '';
  final String userEmail = userBox?.get(HiveKeys.kUserEmail) ?? '';
  final String userAvatar = userBox?.get(HiveKeys.kUserAvatar) ?? '';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    if (cubit.state is! UserProfileAvatarLoadedState) {
      context.read<UserProfileCubit>().getUserProfile();
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: ProfileImage(image: userAvatar),
            title: Text(
              userName,
              style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 18),
            ),
            subtitle: Text(userEmail, style: AppTextStyles.belanosimaSize14),
          ),
          const Divider(height: 1),
          DrawerMenuItem(
            icon: Icons.account_circle_outlined,
            title: AppStrings.viewProfile,
            onTap: () {
              Navigator.pushNamed(context, Routes.userProfileScreen);
            },
          ),

          DrawerMenuItem(
            icon: Icons.people_outline,
            title: AppStrings.myCommunity,
            onTap: () {},
          ),

          DrawerMenuItem(
            icon: Icons.bookmark_border,
            title: AppStrings.savedPosts,
            onTap: () {},
          ),

          const Divider(height: 1),

          // Settings Items
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (_, themeMode) {
              bool isDark = themeMode == ThemeMode.dark;
              return DrawerMenuItem(
                icon: Icons.dark_mode_outlined,
                title: AppStrings.darkMode,
                onTap: () {
                  final theme = isDark ? ThemeMode.light : ThemeMode.dark;
                  context.read<ThemeCubit>().toggleTheme(theme);
                },
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    final theme = value ? ThemeMode.dark : ThemeMode.light;
                    context.read<ThemeCubit>().toggleTheme(theme);
                  },
                ),
              );
            },
          ),

          DrawerMenuItem(
            icon: Icons.help_outline,
            title: AppStrings.helpCenter,
            onTap: () {},
          ),

          DrawerMenuItem(
            icon: Icons.settings_outlined,
            title: AppStrings.settings,
            onTap: () {},
          ),

          const Expanded(child: SizedBox()),

          const Divider(height: 1),

          // Logout Button
          DrawerMenuItem(
            icon: Icons.logout_outlined,
            title: AppStrings.logout,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return LogoutAlertDialog(dialogContext: context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
