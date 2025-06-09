import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';

class PublicationKeyWordsSection extends StatefulWidget {
  const PublicationKeyWordsSection(
      {super.key, required this.onKeywordsChanged});
  final ValueChanged<List<String>> onKeywordsChanged;

  @override
  State<PublicationKeyWordsSection> createState() =>
      _PublicationKeyWordsSectionState();
}

class _PublicationKeyWordsSectionState
    extends State<PublicationKeyWordsSection> {
  late final TextEditingController _keywordController;
  final List<String> _keywords = [];

  @override
  void initState() {
    _keywordController = TextEditingController();
    super.initState();
  }

  void _addKeyword() {
    if (_keywordController.text.isNotEmpty) {
      setState(() {
        _keywords.add(_keywordController.text);
        widget.onKeywordsChanged(_keywords);
        _keywordController.clear();
      });
    }
  }

  void _deleteKeyword(String keyword) {
    setState(() {
      _keywords.remove(keyword);
      widget.onKeywordsChanged(_keywords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          children: _keywords
              .map((keyword) => Chip(
                    label: Text(keyword,
                        style: TextStyle(color: AppColors.steelBlue)),
                    backgroundColor: AppColors.homeBackground,
                    onDeleted: () => _deleteKeyword(keyword),
                  ))
              .toList(),
        ),
        PTxtField(
          controller: _keywordController,
          label: AppStrings.keyWords,
          hint: AppStrings.addKeywords,
          suffixIcon: AddKeywordButton(onPressed: _addKeyword),
        ),
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
        color: AppColors.primary,
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
        icon: Icon(Icons.add, color: AppColors.white),
        onPressed: onPressed,
      ),
    );
  }
}
