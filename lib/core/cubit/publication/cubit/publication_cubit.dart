import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/core/repositories/publication_repository.dart';
import 'package:collabry/features/home_page/model/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'publication_state.dart';

class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(this.repoPublication) : super(PublicationInitial());
  final PublicationRepoBase repoPublication;
  List<CategoryModel> categoriesList = [];

  Future<void> getAllCategories() async {
    try {
      emit(CategoriesLoadingState());
      categoriesList = await repoPublication.getCategories();
      emit(CategoriesLoadedState(categoriesList: categoriesList));
    } on DioException catch (error) {
      handleDioExceptions(error);
    } on ServerException catch (error) {
      emit(CategoriesFailedState(errMsg: error.errModel.getFormattedMessage()));
    }
  }
}
