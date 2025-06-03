import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';

class CreatePublicationContent extends StatefulWidget {
  const CreatePublicationContent({
    super.key,
  });

  @override
  State<CreatePublicationContent> createState() =>
      _CreatePublicationContentState();
}

class _CreatePublicationContentState extends State<CreatePublicationContent> {
  late final TextEditingController _titleController;
  late final TextEditingController _abstractController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _abstractController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _abstractController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreatePublicationTxtField(
          label: AppStrings.title,
          controller: _titleController,
          hint: AppStrings.addUrTitle,
        ),
        SizedBox(height: 16.0),
        CreatePublicationTxtField(
          label: AppStrings.abstract,
          controller: _abstractController,
          hint: AppStrings.enterUrAbstract,
          maxLines: 3,
        ),
      ],
    );
  }
}
