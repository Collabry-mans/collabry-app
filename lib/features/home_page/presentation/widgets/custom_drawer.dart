import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/singleton.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset(Assets.imagesProfileAvatar),
            title: Text(
              'ZASH',
              style: AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            subtitle: const Text('Zash@gmail.com',
                style: AppTextStyles.belanosimaSize14Grey),
          ),
          const Divider(height: 1),
          _buildMenuItem(
            icon: Icons.account_circle_outlined,
            title: 'View Profile',
            onTap: () {},
          ),

          _buildMenuItem(
            icon: Icons.people_outline,
            title: 'My Community',
            onTap: () {},
          ),

          _buildMenuItem(
            icon: Icons.bookmark_border,
            title: 'Saved Posts',
            onTap: () {},
          ),

          const Divider(height: 1),

          // Settings Items
          _buildMenuItem(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
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
            title: 'Help Center',
            onTap: () {},
          ),

          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),

          const Expanded(child: SizedBox()),

          const Divider(height: 1),

          // Logout Button
          _buildMenuItem(
            icon: Icons.logout_outlined,
            title: 'Logout',
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
                            isLoggedIn = false;
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.logInScreen);
                            }
                          });
                        },
                        child: const Text('Logout'),
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
