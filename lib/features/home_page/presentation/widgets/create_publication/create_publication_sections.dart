import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_section_button.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/section_item.dart';
import 'package:flutter/material.dart';

class CreatePublicationSections extends StatefulWidget {
  const CreatePublicationSections({
    super.key,
    required this.sections,
  });

  final List<Map<String, TextEditingController>> sections;

  @override
  State<CreatePublicationSections> createState() =>
      _CreatePublicationSectionsState();
}

class _CreatePublicationSectionsState extends State<CreatePublicationSections> {
  void _addSection() {
    setState(() {
      widget.sections.add({
        kTitle: TextEditingController(),
        kContent: TextEditingController(),
      });
    });
  }

  void _deleteSection(int index) {
    setState(() {
      widget.sections[index][kTitle]!.dispose();
      widget.sections[index][kContent]!.dispose();
      widget.sections.removeAt(index);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final section = widget.sections.removeAt(oldIndex);
      widget.sections.insert(newIndex, section);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReorderableListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          onReorder: _onReorder,
          children: widget.sections.asMap().entries.map((entry) {
            int index = entry.key;
            return Container(
              key: Key('section_$index'),
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Icon(
                          Icons.drag_handle,
                          color: AppColors.lightGray,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SectionItem(
                          index: index,
                          onDelete: () => _deleteSection(index),
                          section: entry.value),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.0),
        AddSectionButton(onPressed: _addSection),
      ],
    );
  }
}
