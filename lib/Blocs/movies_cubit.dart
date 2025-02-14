import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/Model/credits_response.dart';
import 'package:movie_app/Model/images_response.dart';
import 'package:movie_app/Model/movie_details_response.dart';
import 'package:movie_app/Model/source_response.dart';

import '../constants/constants.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialStates());

  SourceResponse? sourceResponse;
  MovieDetailsResponse? movieDetailsResponse;
  ImagesResponse? imagesResponse;
  CreditsResponse? creditsResponse;

  int currentTabIndex = 0;

  List<Results> sources = [];

  Future<void> getSources() async {
    emit(SourceLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/movie/popular?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        sourceResponse = SourceResponse.fromJson(jsonData);
        sources = sourceResponse?.results ?? [];
        emit(SourceSuccessStates(data: sources));
      } else {
        emit(FailedToSourceStates(
            message:
                'Failed to load sources: ${sourceResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToSourceStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieDetailsById(int movieId) async {
    emit(DetailsLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/movie/$movieId?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        movieDetailsResponse = MovieDetailsResponse.fromJson(jsonData);
        emit(DetailsSuccessStates(data: response.body));
      } else {
        emit(FailedToDetailsStates(
            message:
                'Failed to load details: ${movieDetailsResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToDetailsStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieImagesById(int movieId) async {
    emit(ImagesLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/movie/$movieId/images?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        imagesResponse = ImagesResponse.fromJson(jsonData);
        emit(ImagesSuccessStates(data: response.body));
      } else {
        emit(FailedToImagesStates(
            message:
                'Failed to load images: ${imagesResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToImagesStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieCreditsById(int movieId) async {
    emit(CreditsLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/movie/$movieId/credits?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        creditsResponse = CreditsResponse.fromJson(jsonData);
        emit(CreditsSuccessStates(data: response.body));
      } else {
        emit(FailedToCreditsStates(
            message:
                'Failed to load credits: ${creditsResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToCreditsStates(message: "Exception: $e"));
    }
  }

  void onItemSelected(int index, {int? movieId}) {
    if (index != currentTabIndex) {
      currentTabIndex = index;
      emit(ChangeTabSuccess());
    }

    if (movieId != null) {
      getMovieDetailsById(movieId);
      getMovieCreditsById(movieId);
      getMovieImagesById(movieId);
      emit(ChangeSelectedSuccess());
    }
  }

  List<Results> searchItem = [];

  void getSearchItem({required String input}) {
    searchItem = sources
        .where(
          (element) => element.title!.toLowerCase().startsWith(
                input.toLowerCase(),
              ),
        )
        .toList();
    emit(SearchSuccessStates());
  }
}
