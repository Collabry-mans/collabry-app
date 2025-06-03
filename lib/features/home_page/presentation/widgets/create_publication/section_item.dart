import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionItem extends StatelessWidget {
  const SectionItem(
      {super.key,
      required this.index,
      required this.onDelete,
      required this.section});
  final int index;
  final VoidCallback onDelete;
  final Map<String, TextEditingController> section;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Section ${index + 1}',
                style: AppTextStyles.belanosimaSize16BlackBold,
              ),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.txtColor),
                onPressed: onDelete,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          CreatePublicationTxtField(
            controller: section[kTitle]!,
            hint: AppStrings.enterUrTitle,
          ),
          SizedBox(height: 16.0),
          CreatePublicationTxtField(
            controller: section[kContent]!,
            hint: AppStrings.enterUrContent,
            maxLines: 5,
          ),
          SizedBox(height: 16.0),
          SectionOptions(),
        ],
      ),
    );
  }
}

class SectionOptions extends StatelessWidget {
  const SectionOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.selectedColor),
                foregroundColor: AppColors.selectedColor,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.sparcle, height: 20),
                  SizedBox(width: 5),
                  Text(AppStrings.rewriteWithAi),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.selectedColor,
                foregroundColor: AppColors.whiteColor,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.addPhoto, height: 20),
                  SizedBox(width: 5),
                  Text(AppStrings.addPhoto),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.selectedColor,
            foregroundColor: AppColors.whiteColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.addFile, height: 24),
              SizedBox(width: 5),
              Text(AppStrings.addFile),
            ],
          ),
        ),
      ],
    );
  }
}
