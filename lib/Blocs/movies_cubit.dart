import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/movies_states.dart';
import 'package:movie_app/Model/credits_response.dart';
import 'package:movie_app/Model/images_response.dart';
import 'package:movie_app/Model/movie.dart';
import 'package:movie_app/Model/movie_details_response.dart';
import 'package:movie_app/Model/source_response.dart';
import 'package:movie_app/Model/user_model.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/screens/Auth_Screens/login_screen.dart';
import 'package:movie_app/shared/network/cache_network.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitialStates());

  SourceResponse? sourceResponse;
  MovieDetailsResponse? movieDetailsResponse;
  ImagesResponse? imagesResponse;
  CreditsResponse? creditsResponse;
  UserModel? userModel;

  int currentTabIndex = 0;
  List<Results> sources = [];
  List<Results> filteredMovies = [];

  List<Genres> genres = [];
  int? selectedGenreId;
  int selectedAvaterId = 1;

  static MoviesCubit get(context) => BlocProvider.of(context);

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
        filteredMovies = sources;
        emit(SourceSuccessStates(data: sources));
      } else {
        emit(FailedToSourceStates(message: 'Failed to load sources'));
      }
    } catch (e) {
      emit(FailedToSourceStates(message: "Exception: $e"));
    }
  }

  Future<void> getGenres() async {
    emit(GenresLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/genre/movie/list?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        genres = (jsonData["genres"] as List)
            .map((e) => Genres.fromJson(e))
            .toList();
        emit(GenresSuccessStates());
      } else {
        emit(GenresFailedStates(message: 'Failed to load genres'));
      }
    } catch (e) {
      emit(GenresFailedStates(message: "Exception: $e"));
    }
  }

  Future<void> getMoviesByGenre(int genreId) async {
    selectedGenreId = genreId;
    emit(SourceLoadingStates());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/discover/movie?api_key=${Constant.API_KEY}&with_genres=$genreId");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        filteredMovies = (jsonData["results"] as List)
            .map((e) => Results.fromJson(e))
            .toList();
        emit(SourceSuccessStates(data: filteredMovies));
      } else {
        emit(FailedToSourceStates(message: 'Failed to load movies by genre'));
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
        emit(FailedToDetailsStates(message: 'Failed to load details'));
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
        emit(FailedToImagesStates(message: 'Failed to load images'));
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
        emit(FailedToCreditsStates(message: 'Failed to load credits'));
      }
    } catch (e) {
      emit(FailedToCreditsStates(message: "Exception: $e"));
    }
  }

  Future<void> getMovieVideo(int movieId) async {
    emit(MovieVideoLoadingState());
    try {
      Uri url = Uri.parse(
          "${Constant.BASE_URL}/3/movie/$movieId/videos?api_key=${Constant.API_KEY}");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> results = jsonData["results"];
        if (results.isNotEmpty) {
          final videoKey = results.first["key"];
          final videoUrl = "https://www.youtube.com/watch?v=$videoKey";

          if (await canLaunchUrl(Uri.parse(videoUrl))) {
            await launchUrl(Uri.parse(videoUrl),
                mode: LaunchMode.externalApplication);
            emit(MovieVideoLoadedState(videoUrl));
          } else {
            emit(MovieVideoErrorState("Could not launch YouTube"));
          }
        } else {
          emit(MovieVideoErrorState("No video available"));
        }
      } else {
        emit(MovieVideoErrorState("Failed to load video"));
      }
    } catch (e) {
      emit(MovieVideoErrorState("Exception: $e"));
    }
  }

  void onItemSelected(int index, {int? movieId}) {
    if (index != currentTabIndex) {
      currentTabIndex = index;
      emit(ChangeTabSuccess());
      getSources();
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
          (element) =>
              element.title!.toLowerCase().startsWith(input.toLowerCase()),
        )
        .toList();
    emit(SearchSuccessStates());
  }

  Future<void> getUserData() async {
    emit(UserLoadingStates());
    try {
      token = await CacheNetwork.getCacheData(key: "token");
      debugPrint("Token used: $token");
      if (token == null) {
        emit(FailedToUserStates(message: "Token is null"));
        return;
      }
      http.Response response = await http.get(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        userModel = UserModel.fromJson(jsonData);
        emit(
          UserSuccessStates(data: response.body),
        );
        debugPrint("response is : ${response.body}");
      } else {
        emit(
          FailedToUserStates(message: "Failed To Load User Data"),
        );
        debugPrint("response is : ${response.body}");
      }
    } catch (e) {
      emit(FailedToUserStates(message: "Exeption: $e"));
    }
  }

  Future<void> updateUserData(
      {required String email, required int avaterId}) async {
    emit(UpdateUserLoadingStates());
    try {
      http.Response response = await http.patch(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode(
          {"email": email, "avaterId": avaterId},
        ),
      );
      var jsonData = jsonDecode(response.body);
      print("Sending update with avaterId: $avaterId");
      print("Email: ${email}");
      print("Avatar ID: ${avaterId}");

      if (response.statusCode == 200) {
        await getUserData();
        debugPrint("Avater ID after update: ${userModel?.data?.avaterId}");
        userModel = UserModel.fromJson(jsonData);
        selectedAvaterId = avaterId;
        print('Updated User Data: ${userModel?.toJson()}');
        emit(UserSuccessStates(data: userModel));
        emit(
          UpdateUserSuccessStates(data: response.body),
        );
        debugPrint("response is : ${response.body}");
      } else {
        emit(
          FailedToUpdateUserStates(message: "Failed To Load User Data"),
        );
        debugPrint("response is : ${response.body}");
      }
    } catch (e) {
      emit(FailedToUpdateUserStates(message: "Exeption: ${e.toString()}"));
    }
  }

  Future<void> updateAvatarId(int avaterId) async {
    final email = userModel?.data?.email;
    if (email != null) {
      await updateUserData(email: email, avaterId: selectedAvaterId);
      selectedAvaterId = avaterId;
      userModel?.data?.avaterId = selectedAvaterId;
      emit(AvatarUpdatedState(avaterId: avaterId));
    } else {
      emit(FailedToUpdateUserStates(message: "Email is null"));
    }
  }

  Future<void> deleteAccount(String token, BuildContext context) async {
    try {
      emit(UserLoadingStates());

      http.Response response = await http.delete(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        await CacheNetwork.deleteCacheMovie(key: 'token');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account deleted successfully!")),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false);
      } else {
        final errorMessage = response.statusCode == 404
            ? "User not found"
            : "Failed to delete account";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

}
