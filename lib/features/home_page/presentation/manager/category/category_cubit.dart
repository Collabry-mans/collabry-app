import 'package:collabry/features/home_page/presentation/manager/category/category_state.dart';
import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/home_page/data/model/category_model.dart';
import 'package:collabry/features/home_page/data/repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.repoCategory) : super(CategoryInitial());
  final CategoryRepositoryBase repoCategory;
  bool firstTimeLoad = true;

  //* Categories
  Future<void> getAllCategories() async {
    if (!firstTimeLoad) return;
    emit(CategoriesLoadingState());
    try {
      final List<CategoryModel> categoriesList =
          await repoCategory.getCategories();

      firstTimeLoad = false;
      emit(CategoriesLoadedState(categoriesList: categoriesList));
    } on DioException catch (error) {
      handleDioExceptions(error);
    } on ServerException catch (error) {
      emit(CategoriesFailedState(errMsg: error.errModel.getFormattedMessage()));
    }
  }
}
