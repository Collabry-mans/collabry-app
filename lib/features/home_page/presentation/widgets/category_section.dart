import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(30, 5, 0, 5),
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const CategoryTile(),
          itemCount: 8,
        ),
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  const CategoryTile({super.key});

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
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: isSelected ? AppColors.selectedColor : AppColors.whiteColor),
        child: Center(
          child: Text(
            'Topicccccc',
            style: TextStyle(
                color:
                    isSelected ? AppColors.whiteColor : AppColors.selectedColor,
                fontSize: 15,
                fontFamily: fontBelanosima),
          ),
        ),
      ),
    );
  }
}
