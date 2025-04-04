part of 'publication_cubit.dart';

@immutable
sealed class PublicationState {}

final class PublicationInitial extends PublicationState {}

//* categories
final class CategoriesLoadedState extends PublicationState {
  final List<CategoryModel> categoriesList;

  CategoriesLoadedState({required this.categoriesList});
}

final class CategoriesLoadingState extends PublicationState {}

final class CategoriesFailedState extends PublicationState {
  final String errMsg;

  CategoriesFailedState({required this.errMsg});
}

//* publication Creation

final class PublicationCreationLoadingState extends PublicationState {}

final class PublicationCreationLoadedState extends PublicationState {}

final class PublicationCreationFailedState extends PublicationState {
  final String errMsg;
  PublicationCreationFailedState({required this.errMsg});
}
