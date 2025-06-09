import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<CategoryModel> categories;
  final Function(String? categoryId) onCategorySelected;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryTile(
              title: 'All',
              isSelected: currentIndex == 0,
              onTap: () {
                setState(() => currentIndex = 0);
                widget.onCategorySelected(null);
              },
            );
          }
          final categoryIndex = index - 1;
          return CategoryTile(
            title: widget.categories[categoryIndex].name,
            onTap: () {
              setState(() => currentIndex = index);
              widget.onCategorySelected(widget.categories[categoryIndex].id);
            },
            isSelected: currentIndex == index,
          );
        },
        itemCount: widget.categories.length + 1,
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: isSelected ? AppColors.primary : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.belanosimaSize14Grey.copyWith(
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
