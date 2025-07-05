import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class TagsSectionBuilder extends StatelessWidget {
  const TagsSectionBuilder({
    super.key,
    required this.label,
    required this.tags,
    required this.isEditing,
    required this.onAdd,
    required this.onRemove,
    required this.controller,
  });
  final String label;
  final List<String> tags;
  final bool isEditing;
  final Function() onAdd;
  final Function(String) onRemove;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.belanosimaSize14
              .copyWith(color: AppColors.secondary),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags
              .map((tag) => Chip(
                    label: Text(tag),
                    deleteIcon:
                        isEditing ? const Icon(Icons.close, size: 16) : null,
                    onDeleted: isEditing ? () => onRemove(tag) : null,
                  ))
              .toList(),
        ),
        if (isEditing) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    hintText: 'Add new $label',
                    hintStyle: AppTextStyles.belanosimaSize14,
                    border: outLineInputBorder(5),
                  ),
                  style: AppTextStyles.belanosimaSize14,
                  onSubmitted: (_) => onAdd(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
