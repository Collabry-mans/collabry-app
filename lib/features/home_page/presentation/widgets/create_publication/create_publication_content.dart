import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';

class CreatePublicationContent extends StatelessWidget {
  const CreatePublicationContent({
    super.key,
    required this.titleController,
    required this.abstractController,
  });

  final TextEditingController titleController;
  final TextEditingController abstractController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PTxtField(
          label: AppStrings.title,
          controller: titleController,
          hint: AppStrings.addUrTitle,
        ),
        SizedBox(height: 16.0),
        PTxtField(
          label: AppStrings.abstract,
          controller: abstractController,
          hint: AppStrings.enterUrAbstract,
          maxLines: 3,
        ),
      ],
    );
  }
}
