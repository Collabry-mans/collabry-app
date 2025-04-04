import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/category/category_state.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:collabry/features/home_page/presentation/widgets/post_tile.dart';
import 'package:collabry/features/home_page/presentation/widgets/view_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getAllCategories();
    context.read<PublicationCubit>().getAllPublications();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSearch(),
        const ViewHeader(title: AppStrings.topics),
        SliverToBoxAdapter(
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return state is CategoriesLoadedState
                  ? CategorySection(
                      categories: state.categoriesList,
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        BlocBuilder<PublicationCubit, PublicationState>(
          builder: (context, state) {
            return state is PublicationLoadedState
                ? SliverList.builder(
                    itemBuilder: (context, index) {
                      final publication = state.publications[index];
                      return PostTile(
                          authorName: publication.authorName,
                          description: publication.description,
                          categoryName: publication.categoryName,
                          createDate: publication.createdAt,
                          title: publication.title);
                    },
                    itemCount: state.publications.length,
                  )
                : const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
          },
        ),
      ],
    );
  }
}
