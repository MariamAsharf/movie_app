import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Model/credits_response.dart';
import 'package:movie_app/Model/images_response.dart';
import 'package:movie_app/Model/source_response.dart';
import 'package:movie_app/Model/movie_details_response.dart';
import 'package:movie_app/authentication/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  static const String _apiKey = 'bc0ab3e0445b44f445c083c4c1957cd4';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required int avatarId,
  }) async {
    emit(RegisterLoadingStates());
    try {
      http.Response response = await http.post(
        Uri.parse("https://route-movie-apis.vercel.app/auth/register"),
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "confirmPassword": confirmPassword,
          "avatarId": avatarId
        }),
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == 201) {
        emit(RegisterSuccesStates());
      } else {
        emit(FailedToRegisterStates(message: responseBody['message']));
      }
    } catch (e) {
      emit(FailedToRegisterStates(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingStates());
    try {
      http.Response response = await http.post(
        Uri.parse("https://route-movie-apis.vercel.app/auth/login"),
        body: jsonEncode({"email": email, "password": password}),
      );
      var data = jsonDecode(response.body);
      if (data['status'] == 200) {
        emit(LoginSuccesStates());
      } else {
        emit(FailedToLoginStates(message: data['message']));
      }
    } catch (e) {
      emit(FailedToLoginStates(message: e.toString()));
    }
  }

  Future<void> getSources() async {
    emit(ApiLoadingStates());
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/popular", {"api_key": _apiKey});
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        SourceResponse sourceResponse = SourceResponse.fromJson(jsonData);
        emit(ApiSuccessStates(data: sourceResponse));
      } else {
        emit(ApiFailedStates(message: 'Failed to load sources'));
      }
    } catch (e) {
      emit(ApiFailedStates(message: e.toString()));
    }
  }

  Future<void> getMovieDetails(int movieId) async {
    emit(ApiLoadingStates());
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/$movieId", {"api_key": _apiKey, "language": "en-US"});
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        MovieDetailsResponse movieDetails = MovieDetailsResponse.fromJson(jsonData);
        emit(ApiSuccessStates(data: movieDetails));
      } else {
        emit(ApiFailedStates(message: 'Failed to load movie details'));
      }
    } catch (e) {
      emit(ApiFailedStates(message: e.toString()));
    }
  }

  Future<void> getMovieImages(int movieId) async {
    emit(ApiLoadingStates());
    try {
      Uri url = Uri.https("api.themoviedb.org", "/3/movie/$movieId/images", {"api_key": _apiKey});
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        ImagesResponse imageResponse = ImagesResponse.fromJson(jsonData);
        emit(ApiSuccessStates(data: imageResponse));
      } else {
        emit(ApiFailedStates(message: 'Failed to load movie images'));
      }
    } catch (e) {
      emit(ApiFailedStates(message: e.toString()));
    }
  }

  Future<void> getMovieCredits(int movieId) async {
    emit(ApiLoadingStates());
    try {
      Uri url = Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        CreditsResponse creditResponse = CreditsResponse.fromJson(jsonData);
        emit(ApiSuccessStates(data: creditResponse));
      } else {
        emit(ApiFailedStates(message: 'Failed to load credits'));
      }
    } catch (e) {
      emit(ApiFailedStates(message: e.toString()));
    }
  }
}
