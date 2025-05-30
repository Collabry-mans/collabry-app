import 'package:collabry/features/home_page/data/model/category_model.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

//* categories
final class CategoriesLoadedState extends CategoryState {
  final List<CategoryModel> categoriesList;

  CategoriesLoadedState({required this.categoriesList});
}

final class CategoriesLoadingState extends CategoryState {}

final class CategoriesFailedState extends CategoryState {
  final String errMsg;

  CategoriesFailedState({required this.errMsg});
}
