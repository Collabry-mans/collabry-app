import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/category/category_state.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/community/presentation/widgets/channel_tile.dart';
import 'package:collabry/features/community/presentation/widgets/community_tile.dart';
import 'package:collabry/features/community/presentation/widgets/pages_card.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:collabry/features/home_page/presentation/widgets/view_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  void initState() {
    context.read<CategoryCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //* search
        const CustomSearch(),

        //* category
        const ViewHeader(title: AppStrings.topics),
        SliverToBoxAdapter(
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return state is CategoriesLoadedState
                  ? CategorySection(
                      categories: state.categoriesList,
                      onCategorySelected: (String? categoryId) {},
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),

        //* Suggested for u
        const ViewHeader(title: AppStrings.suggestedForU),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 190,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const PagesCard(),
              itemCount: 6,
            ),
          ),
        ),

        //* channel
        const ViewHeader(title: AppStrings.channel),
        SliverToBoxAdapter(
          child: Column(
            children: List.generate(3, (index) => const ChannelTile()),
          ),
        ),

        //* communities
        const ViewHeader(title: AppStrings.communities),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CommunityTile(name: 'Creative Thinker'),
              SizedBox(height: 10),
              CommunityTile(name: 'Flutter Geeks'),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
