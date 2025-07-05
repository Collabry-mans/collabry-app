import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: AppTextStyles.belanosimaSize14,
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      minLeadingWidth: 20,
    );
  }
}
