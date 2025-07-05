import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/data/models/category_model.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_keywords.dart';
import 'package:flutter/material.dart';

class PublicationSettings extends StatefulWidget {
  const PublicationSettings({
    super.key,
    required this.onPrivacyChanged,
    required this.onStatusChanged,
    required this.onCategoryChanged,
    required this.onKeywordsChanged,
    required this.categories,
  });

  final ValueChanged<String> onPrivacyChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<List<String>> onKeywordsChanged;
  final List<CategoryModel> categories;

  @override
  State<PublicationSettings> createState() => _PublicationSettingsState();
}

class _PublicationSettingsState extends State<PublicationSettings> {
  final _keywordController = TextEditingController();

  String _privacy = privacyList[0];
  String _status = statusList[0];

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.publicationSettings,
          style: AppTextStyles.belanosimaSize12Black.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 8.0),
        DropDownField(
          label: AppStrings.privacy,
          items: privacyList
              .map((privacy) => DropdownMenuItem<String>(
                    value: privacy,
                    child: Text(privacy, style: AppTextStyles.belanosimaSize14),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _privacy = value ?? _privacy);
            widget.onPrivacyChanged(_privacy);
          },
          value: _privacy,
        ),
        const SizedBox(height: 16.0),
        DropDownField(
          label: AppStrings.status,
          items: statusList
              .map((status) => DropdownMenuItem<String>(
                    value: status,
                    child: Text(status, style: AppTextStyles.belanosimaSize14),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _status = value ?? _status);
            widget.onStatusChanged(_status);
          },
          value: _status,
        ),
        const SizedBox(height: 16.0),
        DropDownField(
          label: AppStrings.category,
          items: widget.categories
              .map((category) => DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name,
                        style: AppTextStyles.belanosimaSize14),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) widget.onCategoryChanged(newValue);
          },
          value: widget.categories[0].id,
        ),
        const SizedBox(height: 16.0),
        PublicationKeyWordsSection(onKeywordsChanged: widget.onKeywordsChanged),
        SizedBox(height: 8.0),
      ],
    );
  }
}
