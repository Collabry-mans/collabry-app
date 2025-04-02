import 'package:collabry/core/cubit/publication/cubit/publication_cubit.dart';
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
    // Fetch categories when the widget initializes
    context.read<PublicationCubit>().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSearch(),
        const ViewHeader(title: AppStrings.topics),
        BlocBuilder<PublicationCubit, PublicationState>(
          builder: (context, state) {
            if (state is CategoriesLoadingState) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is CategoriesLoadedState) {
              return CategorySection(categories: state.categoriesList);
            } else if (state is CategoriesFailedState) {
              return SliverToBoxAdapter(
                child: Center(child: Text('Error: ${state.errMsg}')),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox());
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        SliverList.builder(
          itemBuilder: (context, index) => const PostTile(),
          itemCount: 14,
        ),
      ],
    );
  }
}
