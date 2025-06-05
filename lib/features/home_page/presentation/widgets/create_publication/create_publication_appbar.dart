import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CreatePublicationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreatePublicationAppBar({
    super.key,
    required this.onPublish,
  });

  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.whiteColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.selectedColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.homeBgColor,
                ),
                child: Text(
                  'Preview',
                  style: AppTextStyles.belanosimaSize16Purple
                      .copyWith(color: AppColors.txtKeywordColor),
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: onPublish,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.selectedColor,
                  foregroundColor: AppColors.whiteColor,
                ),
                child: Text(
                  'Publish',
                  style: AppTextStyles.belanosimaSize16Purple
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
