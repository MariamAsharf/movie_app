abstract class MoviesStates {}

class MoviesInitialStates extends MoviesStates {}

class ChangeSelectedSuccess extends MoviesStates {}

class ChangeTabSuccess extends MoviesStates {}

class SourceLoadingStates extends MoviesStates {}

class SourceSuccessStates extends MoviesStates {
  final dynamic data;

  SourceSuccessStates({required this.data});
}

class FailedToSourceStates extends MoviesStates {
  final String message;

  FailedToSourceStates({required this.message});
}

class ImagesLoadingStates extends MoviesStates {}

class ImagesSuccessStates extends MoviesStates {
  final dynamic data;

  ImagesSuccessStates({required this.data});
}

class FailedToImagesStates extends MoviesStates {
  final String message;

  FailedToImagesStates({required this.message});
}

class DetailsLoadingStates extends MoviesStates {}

class DetailsSuccessStates extends MoviesStates {
  final dynamic data;

  DetailsSuccessStates({required this.data});
}

class FailedToDetailsStates extends MoviesStates {
  final String message;

  FailedToDetailsStates({required this.message});
}

class CreditsLoadingStates extends MoviesStates {}

class CreditsSuccessStates extends MoviesStates {
  final dynamic data;

  CreditsSuccessStates({required this.data});
}

class FailedToCreditsStates extends MoviesStates {
  final String message;

  FailedToCreditsStates({required this.message});
}

class SearchSuccessStates extends MoviesStates {}

class GenresLoadingStates extends MoviesStates {}

class GenresSuccessStates extends MoviesStates {}

class GenresFailedStates extends MoviesStates {
  final String message;

  GenresFailedStates({required this.message});
}

class MovieVideoLoadingState extends MoviesStates {}

class MovieVideoLoadedState extends MoviesStates {
  final String videoUrl;

  MovieVideoLoadedState(this.videoUrl);
}

class MovieVideoErrorState extends MoviesStates {
  final String error;

  MovieVideoErrorState(this.error);
}

class UserLoadingStates extends MoviesStates {}

class UserSuccessStates extends MoviesStates {
  final dynamic data;

  UserSuccessStates({required this.data});
}

class FailedToUserStates extends MoviesStates {
  final String message;

  FailedToUserStates({required this.message});
}

class UpdateUserLoadingStates extends MoviesStates {}

class UpdateUserSuccessStates extends MoviesStates {
  final dynamic data;

  UpdateUserSuccessStates({required this.data});
}

class FailedToUpdateUserStates extends MoviesStates {
  final String message;

  FailedToUpdateUserStates({required this.message});
}

class UserAvatarUpdatedState extends MoviesStates {}

class AvatarUpdatedState extends MoviesStates {
  final int avaterId;

  AvatarUpdatedState({required this.avaterId});
}

class DeleteAccountSuccessState extends MoviesStates {}

class DeleteAccountFailureState extends MoviesStates {
  final String message;

  DeleteAccountFailureState({required this.message});
}

class FavouriteLoadingStates extends MoviesStates {}

class FavouriteSuccessState extends MoviesStates {}

class FavouriteFailureState extends MoviesStates {
  final String message;

  FavouriteFailureState({required this.message});
}
