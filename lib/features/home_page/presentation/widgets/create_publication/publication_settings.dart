import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';

class PublicationSettings extends StatefulWidget {
  const PublicationSettings({
    super.key,
  });

  @override
  State<PublicationSettings> createState() => _PublicationSettingsState();
}

class _PublicationSettingsState extends State<PublicationSettings> {
  final _keywordController = TextEditingController();

  String _privacy = privacyList[0];
  String _status = statusList[0];
  String _category = categoriesList[0];

  final List<String> _keywords = [];

  void _addKeyword() {
    if (_keywordController.text.isNotEmpty) {
      setState(() {
        _keywords.add(_keywordController.text);
        _keywordController.clear();
      });
    }
  }

  void _deleteKeyword(String keyword) {
    setState(() {
      _keywords.remove(keyword);
    });
  }

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
        SizedBox(height: 8.0),
        DropDownField(
          label: AppStrings.privacy,
          value: _privacy,
          items: privacyList,
          onChanged: (String? newValue) {
            setState(() {
              _privacy = newValue ?? _privacy;
            });
          },
        ),
        SizedBox(height: 16.0),
        DropDownField(
          label: AppStrings.status,
          value: _status,
          items: statusList,
          onChanged: (String? newValue) {
            setState(() {
              _status = newValue ?? _status;
            });
          },
        ),
        SizedBox(height: 16.0),
        DropDownField(
          label: AppStrings.category,
          value: _category,
          items: categoriesList,
          onChanged: (String? newValue) {
            setState(() {
              _category = newValue ?? _category;
            });
          },
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          children: _keywords
              .map((keyword) => Chip(
                    label: Text(keyword,
                        style: TextStyle(color: AppColors.txtKeywordColor)),
                    backgroundColor: AppColors.homeBgColor,
                    onDeleted: () => _deleteKeyword(keyword),
                  ))
              .toList(),
        ),
        CreatePublicationTxtField(
          controller: _keywordController,
          label: AppStrings.keyWords,
          hint: AppStrings.addKeywords,
          suffixIcon: AddKeywordButton(onPressed: _addKeyword),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}

class AddKeywordButton extends StatelessWidget {
  const AddKeywordButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.selectedColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.add, color: AppColors.whiteColor),
        onPressed: onPressed,
      ),
    );
  }
}
