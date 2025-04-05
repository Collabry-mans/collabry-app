import 'package:collabry/core/errors/exception_handling.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';
import 'package:collabry/features/home_page/data/repository/publication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'publication_state.dart';

class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(this.repoPublication) : super(PublicationInitial());
  final PublicationRepoBase repoPublication;

  //* publication
  // create publication
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

  // getpublication
  Future<void> getAllPublications() async {
    emit(PublicationLoadingState());
    try {
      final List<Publication> publicationsList =
          await repoPublication.getPublications();
      emit(PublicationLoadedState(publications: publicationsList));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(PublicationFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }

  // get publication by category
  Future<void> getPublicationsByCategory(String categoryId) async {
    emit(PublicationLoadingState());
    try {
      final List<Publication> publicationsList =
          await repoPublication.getPublicationsByCategory(categoryId);
      emit(PublicationLoadedState(publications: publicationsList));
    } on DioException catch (e) {
      handleDioExceptions(e);
    } on ServerException catch (e) {
      emit(PublicationFailedState(errMsg: e.errModel.getFormattedMessage()));
    }
  }
}
