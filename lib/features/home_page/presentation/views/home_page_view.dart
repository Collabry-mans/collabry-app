import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:collabry/features/home_page/presentation/widgets/post_tile.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomSearch(),
                ),
                Text(
                  AppStrings.topics,
                  style: AppTextStyles.belanosimaSize14Grey
                      .copyWith(color: AppColors.headerColor),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: CategorySection()),
        SliverList.builder(
          itemBuilder: (context, index) => const PostTile(),
          itemCount: 8,
        ),
      ],
    );
  }
}
