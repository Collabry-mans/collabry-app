import 'package:collabry/features/home_page/presentation/manager/category/category_state.dart';
import 'package:collabry/features/home_page/data/models/category_model.dart';
import 'package:collabry/features/home_page/data/repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.repoCategory) : super(CategoryInitial());
  final CategoryRepositoryBase repoCategory;
  bool firstTimeLoad = true;

  //* Categories
  Future<void> getAllCategories() async {
    if (!firstTimeLoad) return;
    emit(CategoriesLoadingState());
    final result = await repoCategory.getCategories();
    result.when(
      onSuccess: (List<CategoryModel> categoriesList) {
        firstTimeLoad = false;
        emit(CategoriesLoadedState(categoriesList: categoriesList));
      },
      onFailure: (error) {
        emit(CategoriesFailedState(errMsg: error.message));
      },
    );
  }
}
