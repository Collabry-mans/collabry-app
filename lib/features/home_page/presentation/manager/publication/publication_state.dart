part of 'publication_cubit.dart';

@immutable
sealed class PublicationState {}

final class PublicationInitial extends PublicationState {}

//* publication Creation

final class PublicationCreationLoadingState extends PublicationState {}

final class PublicationCreationLoadedState extends PublicationState {}

final class PublicationCreationFailedState extends PublicationState {
  final ApiErrorModel errModel;
  PublicationCreationFailedState({required this.errModel});
}

//* publication get
final class PublicationLoadingState extends PublicationState {}

final class PublicationLoadedState extends PublicationState {
  final List<Publication> publications;

  PublicationLoadedState({required this.publications});
}

final class PublicationFailedState extends PublicationState {
  final ApiErrorModel errModel;
  PublicationFailedState({required this.errModel});
}

//* publicationById states
final class PublicationByIdLoadingState extends PublicationState {}

final class PublicationByIdLoadedState extends PublicationState {
  final Publication publication;

  PublicationByIdLoadedState({required this.publication});
}

final class PublicationByIdFailedState extends PublicationState {
  final ApiErrorModel errModel;
  PublicationByIdFailedState({required this.errModel});
}

//* user publication change status
final class UserPublicationStateFailed extends PublicationState {
  final ApiErrorModel errModel;
  UserPublicationStateFailed({required this.errModel});
}

final class UserPublicationStateSuccess extends PublicationState {}

//* Publication editing states
final class PublicationEditedSuccess extends PublicationState {
  final Publication publication;

  PublicationEditedSuccess({required this.publication});
}

final class PublicationEditedFailed extends PublicationState {
  final ApiErrorModel errModel;
  PublicationEditedFailed({required this.errModel});
}
