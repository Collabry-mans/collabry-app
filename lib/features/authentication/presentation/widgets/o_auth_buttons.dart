import 'package:collabry/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OAuthButtons extends StatefulWidget {
  const OAuthButtons({super.key, required this.icon});
  final IconData icon;

  @override
  State<OAuthButtons> createState() => _OAuthButtonsState();
}

class _OAuthButtonsState extends State<OAuthButtons> {
  Color iconColor = AppColors.oAuth;
  Color containerColor = Colors.transparent;
  void _updateColors(bool isPressed) {
    setState(() {
      iconColor = isPressed ? AppColors.white : AppColors.oAuth;
      containerColor = isPressed ? AppColors.oAuth : Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _updateColors(true), // Pressed state
      onTapUp: (_) => _updateColors(false), // Released state
      onTapCancel: () => _updateColors(false), // Cancelled press
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: AppColors.oAuthBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Icon(
            widget.icon,
            size: 30,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
