import 'package:collabry/core/di/di.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({
    super.key,
    required this.dialogContext,
  });
  final BuildContext dialogContext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout',
          style: AppTextStyles.belanosimaSize24W600Purple),
      content: Text(
        'Are you sure you want to logout?',
        style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 18),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(); // Close dialog
          },
          child: Text(
            'Cancel',
            style: AppTextStyles.belanosimaSize14,
          ),
        ),
        TextButton(
          onPressed: () async {
            await secureStorage.deleteAll().then((_) {
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed(Routes.logInScreen);
              }
            });
          },
          child: Text(AppStrings.logout,
              style: AppTextStyles.belanosimaSize14
                  .copyWith(color: AppColors.warning)),
        ),
      ],
    );
  }
}
