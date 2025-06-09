import 'package:collabry/core/api/networking/api_error_model.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';
import 'package:collabry/features/home_page/data/repository/publication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'publication_state.dart';

class PublicationCubit extends Cubit<PublicationState> {
  PublicationCubit(this.repoPublication) : super(PublicationInitial());
  final PublicationRepoBase repoPublication;

  //* publication
  // create publication
  Future<void> createPublication({
    required String title,
    required String description,
    required List<String> keywords,
    required String language,
    required String visibility,
    required String categoryId,
  }) async {
    emit(PublicationCreationLoadingState());
    final result = await repoPublication.createPublication(
        title, description, keywords, language, visibility, categoryId);
    result.when(
      onSuccess: (_) {
        emit(PublicationCreationLoadedState());
      },
      onFailure: (error) {
        emit(PublicationCreationFailedState(errModel: error));
      },
    );
  }

  // create section
  Future<void> createSection({
    required String title,
    required String orderIndex,
    required String type,
    required String content,
    required List<String> files,
    required String publicationId,
  }) async {
    emit(SectionCreationLoadingState());
    final result = await repoPublication.createSection(
      title: title,
      orderIndex: orderIndex,
      type: type,
      content: content,
      files: files,
      publicationId: publicationId,
    );
    result.when(
      onSuccess: (_) {
        emit(SectionCreationLoadedState());
      },
      onFailure: (error) {
        emit(SectionCreationFailedState(errModel: error));
      },
    );
  }

  // get all publications
  Future<void> getAllPublications() async {
    emit(PublicationLoadingState());
    final result = await repoPublication.getPublications();
    result.when(
      onSuccess: (publicationsList) {
        emit(PublicationLoadedState(publications: publicationsList));
      },
      onFailure: (error) {
        emit(PublicationFailedState(errModel: error));
      },
    );
  }

  // get publication by category
  Future<void> getPublicationsByCategory(String categoryId) async {
    emit(PublicationLoadingState());
    final result = await repoPublication.getPublicationsByCategory(categoryId);
    result.when(
      onSuccess: (publicationsList) {
        emit(PublicationLoadedState(publications: publicationsList));
      },
      onFailure: (error) {
        emit(PublicationFailedState(errModel: error));
      },
    );
  }

  // get publication by id
  Future<void> getPublicationById(String publicationId) async {
    emit(PublicationByIdLoadingState());
    final result = await repoPublication.getPublicationById(publicationId);
    result.when(
      onSuccess: (publication) {
        emit(PublicationByIdLoadedState(publication: publication));
      },
      onFailure: (error) {
        emit(PublicationByIdFailedState(errModel: error));
      },
    );
  }

  // get all user publications
  Future<void> getAllUserPublications() async {
    emit(PublicationLoadingState());
    final result = await repoPublication.getUserPublications();
    result.when(
      onSuccess: (publicationsList) {
        emit(PublicationLoadedState(publications: publicationsList));
      },
      onFailure: (error) {
        emit(PublicationFailedState(errModel: error));
      },
    );
  }

  // get user publication by id
  Future<void> getUserPublicationById(String userPublicationId) async {
    emit(PublicationByIdLoadingState());
    final result =
        await repoPublication.getUserPublicationById(userPublicationId);
    result.when(
      onSuccess: (publication) {
        emit(PublicationByIdLoadedState(publication: publication));
      },
      onFailure: (error) {
        emit(PublicationByIdFailedState(errModel: error));
      },
    );
  }

  // change publication status
  Future<void> changePublicationStatus(
      String publicationId, String status) async {
    emit(UserPublicationStateLoading());
    final result =
        await repoPublication.changePublicationStatus(publicationId, status);
    result.when(
      onSuccess: (_) {
        emit(UserPublicationStateSuccess());
      },
      onFailure: (error) {
        emit(UserPublicationStateFailed(errModel: error));
      },
    );
  }

  // edit publication data
  Future<void> changePublicationData(
      String publicationId,
      String? title,
      String? description,
      String? language,
      String? visibility,
      String? categoryId,
      List<String?>? keywords) async {
    final result = await repoPublication.changePublicationData(publicationId,
        title, description, language, visibility, categoryId, keywords);
    result.when(
      onSuccess: (editedPublication) {
        emit(PublicationEditedSuccess(publication: editedPublication));
      },
      onFailure: (error) {
        emit(PublicationEditedFailed(errModel: error));
      },
    );
  }
}
