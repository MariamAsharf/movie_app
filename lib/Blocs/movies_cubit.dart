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

  int selectedIndex = 0;

  changeSelected(int index) async {
    selectedIndex = index;
    await getMovieImages();
    await getMovieCredits();
    await getMovieDetails();
    emit(ChangeSelectedSuccess());
  }

  List<Results> sources = [];

  Future<void> getSources() async {
    emit(SourceLoadingStates());
    try {
      Uri url = Uri.parse("${Constant.BASE_URL}/3/movie/popular?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        sourceResponse = SourceResponse.fromJson(jsonData);
        sources = sourceResponse?.results ?? [];
        if (sources.isNotEmpty) {
          selectedIndex = 0;
          await getMovieDetails();
          await getMovieCredits();
          await getMovieImages();
        }
        emit(SourceSuccessStates(data: sources));
      } else {
        emit(FailedToSourceStates(
            message: 'Failed to load sources: ${sourceResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToSourceStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieDetails() async {
    emit(DetailsLoadingStates());
    try {
      Uri url = Uri.parse("${Constant.BASE_URL}/3/movie/${sources[selectedIndex].id}?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        movieDetailsResponse = MovieDetailsResponse.fromJson(jsonData);
        emit(DetailsSuccessStates(data: response.body));
      } else {
        emit(FailedToDetailsStates(
            message: 'Failed to load details: ${movieDetailsResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToDetailsStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieImages() async {
    emit(ImagesLoadingStates());
    try {
      Uri url = Uri.parse("${Constant.BASE_URL}/3/movie/${sources[selectedIndex].id}/images?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        imagesResponse = ImagesResponse.fromJson(jsonData);
        emit(ImagesSuccessStates(data: response.body));
      } else {
        emit(FailedToImagesStates(
            message: 'Failed to load images: ${imagesResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToImagesStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieCredits() async {
    emit(CreditsLoadingStates());
    try {
      Uri url = Uri.parse("${Constant.BASE_URL}/3/movie/${sources[selectedIndex].id}/credits?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        creditsResponse = CreditsResponse.fromJson(jsonData);
        emit(CreditsSuccessStates(data: response.body));
      } else {
        emit(FailedToCreditsStates(
            message: 'Failed to load credits: ${creditsResponse?.status_message}'));
      }
    } catch (e) {
      emit(FailedToCreditsStates(message: "Exception: $e"));
    }
  }
}
