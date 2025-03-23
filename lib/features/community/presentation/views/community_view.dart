import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_selector.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:flutter/material.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Search bar
        const CustomSearch(),

        // Topics section
        const CategorySelector(title: AppStrings.topics),
        const CategorySection(),

        // Suggested For You section with improved spacing
        SliverPadding(
          padding: const EdgeInsets.only(top: 8.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppStrings.suggestedForU,
                    style: AppTextStyles.belanosimaSize14Grey,
                  ),
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  height: 235,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => const PagesCard(),
                    itemCount: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PagesCard extends StatelessWidget {
  const PagesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Close button aligned to the right
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, size: 18),
              padding: const EdgeInsets.all(8),
            ),
          ),

          // Profile image
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Assets.imagesProfileAvatar,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          // Name text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Unity',
              style: AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),

          // Follow button
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.selectedColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                minimumSize: const Size(double.infinity, 32),
              ),
              child: const Text(
                AppStrings.follow,
                style: AppTextStyles.belanosimaSize12White,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
