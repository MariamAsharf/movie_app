import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/layout_states.dart';
import 'package:movie_app/Model/user_profile_response.dart';
import 'package:movie_app/constants/constants.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  UserProfileModel? userProfileModel;

  static getUserData() async {
    try {
      final response = await http.get(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {
          "Authorization": token!,
          "lang": "en",
        },
      );

      var responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        userProfileModel = UserProfileModel.fromJson(responseData['data']);
        print("response is :$responseData");
        emit(GetUserDataSuccessState());
      } else {
        print("response is :$responseData");

        emit(FailedToGetUserDataState(error: "Invalid response format"));
      }
    } catch (e) {
      emit(FailedToGetUserDataState(error: "Error: $e"));
    }
  }
}
