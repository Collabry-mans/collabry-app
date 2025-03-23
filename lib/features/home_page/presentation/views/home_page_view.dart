import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_selector.dart';
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
        const CustomSearch(),
        const CategorySelector(title: AppStrings.topics),
        const CategorySection(),
        SliverList.builder(
          itemBuilder: (context, index) => const PostTile(),
          itemCount: 14,
        ),
      ],
    );
  }
}
