import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/Model/credits_response.dart';
import 'package:movie_app/Model/images_response.dart';
import 'package:movie_app/Model/movie_details_response.dart';
import 'package:movie_app/Model/source_response.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialStates());

  List<SourceResponse> sources = [];
  void getSources() async {
    Response response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/popular"),
    );
    final responseBody = jsonDecode(response.body);

    emit(SourceLoadingStates());
    if (response.statusCode == 200) {
      for (var item in responseBody['results']) {
        print(item);

        sources.add(SourceResponse.fromJson(item));
      }
      emit(SourceSuccessStates(data: sources));
    } else {
      emit(FailedToSourceStates(message: 'Failed to load sources'));
    }
  }
      

List<MovieDetailsResponse> movies = [];
  void getMovieDetails(int movieId) async {
    Response response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/{movie_id}"),
    );
    final responseBody = jsonDecode(response.body);

    emit(DetailsLoadingStates());
    if (response.statusCode == 200) {
      for (var item in responseBody['genres']) {
        print(item);

        sources.add(SourceResponse.fromJson(item));
      }
      emit(DetailsSuccessStates(data: movies));
    } else {
      emit(FailedToDetailsStates(message: 'Failed to load sources'));
    }
  }

  List<ImagesResponse> images = [];
   void getMovieImage(int movieId) async {
    Response response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/{movie_id}/images"),
    );
    final responseBody = jsonDecode(response.body);

    emit(ImagesLoadingStates());
    if (response.statusCode == 200) {
      for (var item in responseBody['results']) {
        print(item);

        sources.add(SourceResponse.fromJson(item));
      }
      emit( ImagesSuccessStates(data: images));
    } else {
      emit(FailedToImagesStates(message: 'Failed to load sources'));
    }
  }

List<CreditsResponse> credits = [];
   void getMoviesCredits(int movieId) async {
    Response response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/{movie_id}/credits"),
    );
    final responseBody = jsonDecode(response.body);

    emit(CreditsLoadingStates());
    if (response.statusCode == 200) {
      for (var item in responseBody['cast']) {
        print(item);

        sources.add(SourceResponse.fromJson(item));
      }
      emit(CreditsSuccessStates(data: credits));
    } else {
      emit(FailedToCreditsStates(message: 'Failed to load sources'));
    }
  }
}
