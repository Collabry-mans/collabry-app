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
    emit(CategoriesLoadingState());
    try {
      categoriesList = await repoPublication.getCategories();
      debugPrint(categoriesList[0].name);
      emit(CategoriesLoadedState(categoriesList: categoriesList));
    } on DioException catch (error) {
      handleDioExceptions(error);
    } on ServerException catch (error) {
      emit(CategoriesFailedState(errMsg: error.errModel.getFormattedMessage()));
    }
  }

  Future<void> createPublication(
      {required String title,
      required String description,
      required List<String> keywords,
      required String language,
      required String visibility,
      required String categoryId}) async {
    try {
      emit(PublicationCreationLoadingState());
      await repoPublication.createPublication(
          title, description, keywords, language, visibility, categoryId);
      emit(PublicationCreationLoadedState());
    } on DioException catch (error) {
      handleDioExceptions(error);
    } on ServerException catch (e) {
      emit(PublicationCreationFailedState(
          errMsg: e.errModel.getFormattedMessage()));
    }
  }
}
