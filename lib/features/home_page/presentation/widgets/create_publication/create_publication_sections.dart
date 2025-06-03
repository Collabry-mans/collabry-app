import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_section_button.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/section_item.dart';
import 'package:flutter/material.dart';

class CreatePublicationSections extends StatefulWidget {
  const CreatePublicationSections({
    super.key,
  });

  @override
  State<CreatePublicationSections> createState() =>
      _CreatePublicationSectionsState();
}

class _CreatePublicationSectionsState extends State<CreatePublicationSections> {
  late final List<Map<String, TextEditingController>> _sections;
  @override
  void initState() {
    _sections = [
      {
        kTitle: TextEditingController(),
        kContent: TextEditingController(),
      }
    ];
    super.initState();
  }

  @override
  void dispose() {
    for (var section in _sections) {
      section[kTitle]?.dispose();
      section[kContent]?.dispose();
    }
    super.dispose();
  }

  void _addSection() {
    setState(() {
      _sections.add({
        kTitle: TextEditingController(),
        kContent: TextEditingController(),
      });
    });
  }

  void _deleteSection(int index) {
    setState(() {
      _sections[index][kTitle]!.dispose();
      _sections[index][kContent]!.dispose();
      _sections.removeAt(index);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final section = _sections.removeAt(oldIndex);
      _sections.insert(newIndex, section);
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
          children: _sections.asMap().entries.map((entry) {
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
                color: AppColors.whiteColor,
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
                          color: AppColors.txtColor,
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
