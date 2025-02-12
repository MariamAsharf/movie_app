abstract class MoviesStates {}

class MoviesInitialStates extends MoviesStates {}

class ChangeSelectedSuccess extends MoviesStates {}

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
