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
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getAllCategories();
    _loadPublications();
  }

  void _loadPublications() {
    if (selectedCategoryId != null) {
      context
          .read<PublicationCubit>()
          .getPublicationsByCategory(selectedCategoryId!);
    } else {
      context.read<PublicationCubit>().getAllPublications();
    }
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
                      onCategorySelected: (categoryId) {
                        setState(() {
                          selectedCategoryId == categoryId
                              ? null
                              : {
                                  selectedCategoryId = categoryId,
                                  _loadPublications(),
                                };
                        });
                      },
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        BlocBuilder<PublicationCubit, PublicationState>(
          builder: (context, state) {
            if (state is PublicationLoadedState) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  final reversedIndex = state.publications.length - 1 - index;
                  final publication = state.publications[reversedIndex];
                  return PostTile(
                    authorName: publication.authorName,
                    description: publication.description,
                    categoryName: publication.categoryName,
                    createDate: publication.createdAt,
                    title: publication.title,
                  );
                },
                itemCount: state.publications.length,
              );
            }
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ],
    );
  }
}
