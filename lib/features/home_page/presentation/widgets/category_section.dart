import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/data/model/category_model.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryTile(
          title: categories[index].name,
        ),
        itemCount: categories.length,
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  const CategoryTile({super.key, required this.title});
  final String title;
  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isSelected = !isSelected),
      child: Container(
        margin: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: isSelected ? AppColors.selectedColor : AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.title,
            style: AppTextStyles.belanosimaSize14Grey.copyWith(
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.selectedColor),
          ),
        ),
      ),
    );
  }
}
