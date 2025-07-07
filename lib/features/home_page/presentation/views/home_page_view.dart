import 'package:collabry/features/home_page/presentation/manager/category/category_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_state.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
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
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await context.read<CategoryCubit>().getAllCategories();
    await _loadPublications();
  }

  Future<void> _loadPublications() async {
    if (selectedCategoryId != null) {
      await context
          .read<PublicationCubit>()
          .getPublicationsByCategory(selectedCategoryId!);
    } else {
      await context.read<PublicationCubit>().getAllPublications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _loadPublications,
      child: CustomScrollView(
        slivers: [
          const CustomSearch(),
          const ViewHeader(title: AppStrings.topics),
          SliverToBoxAdapter(
            child: _categoryBlocBuilder(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          _publicationBlocBuilder(),
        ],
      ),
    );
  }

  Widget _publicationBlocBuilder() {
    return BlocBuilder<PublicationCubit, PublicationState>(
      builder: (context, state) {
        if (state is PublicationLoadedState) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              final reversedIndex = state.publications.length - 1 - index;
              final publication = state.publications[reversedIndex];
              return PostTile(
                publication: publication,
                type: PostTileType.homePage,
              );
            },
            itemCount: state.publications.length,
          );
        } else if (state is PublicationFailedState) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.errModel.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _categoryBlocBuilder() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return state is CategoriesLoadedState
            ? CategorySection(
                categories: state.categoriesList,
                onCategorySelected: (categoryId) async {
                  setState(() {
                    selectedCategoryId =
                        selectedCategoryId == categoryId ? null : categoryId;
                  });
                  await _loadPublications();
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
