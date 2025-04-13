import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/layout_states.dart';
import 'package:movie_app/Model/user_prof.dart';
import 'package:movie_app/constants/constants.dart';


class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  UserProf? userProf;

 Future<void>getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      final response = await http.get(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {
          if (token != null) "Authorization": token!,
          "lang": "en",
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          userProf = UserProf.fromJson(responseData['data']);
          emit(GetUserDataSuccessState());
        } else {
          emit(FailedToGetUserDataState(error: "Invalid response format"));
        }
      } else {
        emit(FailedToGetUserDataState(error: "Server Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(FailedToGetUserDataState(error: "Exception: $e"));
    }
  }

}
