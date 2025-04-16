part of 'publication_cubit.dart';

@immutable
sealed class PublicationState {}

final class PublicationInitial extends PublicationState {}

//* publication Creation

final class PublicationCreationLoadingState extends PublicationState {}

final class PublicationCreationLoadedState extends PublicationState {}

final class PublicationCreationFailedState extends PublicationState {
  final String errMsg;
  PublicationCreationFailedState({required this.errMsg});
}

//* publication get
final class PublicationLoadingState extends PublicationState {}

final class PublicationLoadedState extends PublicationState {
  final List<Publication> publications;

  PublicationLoadedState({required this.publications});
}

final class PublicationFailedState extends PublicationState {
  final String errMsg;
  PublicationFailedState({required this.errMsg});
}

//* publicationById states
final class PublicationByIdLoadingState extends PublicationState {}

final class PublicationByIdLoadedState extends PublicationState {
  final Publication publication;

  PublicationByIdLoadedState({required this.publication});
}

final class PublicationByIdFailedState extends PublicationState {
  final String errMsg;
  PublicationByIdFailedState({required this.errMsg});
}

//* user publication change status
final class UserPublicationStateFailed extends PublicationState {
  final String errMsg;
  UserPublicationStateFailed({required this.errMsg});
}

final class UserPublicationStateSuccess extends PublicationState {}
