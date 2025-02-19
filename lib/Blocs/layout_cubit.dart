import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/layout_states.dart';
import 'package:movie_app/Model/user2_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState()) {
    _initCubit();
  }

  User2Response? user2response;
  String? token;

  Future<void> _initCubit() async {
    await loadToken();
    if (token != null) {
      getUserData();
    } else {
      emit(FailedToGetUserDataState(error: "Token is missing"));
    }
  }

  // تحميل التوكين من SharedPreferences
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    print("🔄 Loaded Token: $token");
  }

  // جلب بيانات المستخدم
  Future<void> getUserData() async {
    if (token == null) {
      emit(FailedToGetUserDataState(error: "Token is missing"));
      print("❌ Token is missing");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://route-movie-apis.vercel.app/profile"),
        headers: {
          "Authorization": "Bearer $token",
          "lang": "en",
        },
      );

      var responseData = jsonDecode(response.body);
      print("✅ Response Data: $responseData");

      if (response.statusCode == 200 && responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        user2response = User2Response.fromJson(responseData);
        emit(GetUserDataSuccessState());
      } else {
        emit(FailedToGetUserDataState(error: "Invalid response format"));
      }
    } catch (e) {
      emit(FailedToGetUserDataState(error: "Error: $e"));
    }
  }

  // جلب الأفلام المفضلة
  Future<void> getFav() async {
    if (token == null) {
      emit(FaildToGetFavState());
      print("❌ Cannot fetch favorites: Token is missing");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://route-movie-apis.vercel.app/favorites/add"),
        headers: {
          "lang": "en",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print("✅ Favorites fetched successfully");
        emit(GetFavSuccessState());
      } else {
        print("❌ Failed to fetch favorites");
        emit(FaildToGetFavState());
      }
    } catch (e) {
      print("❌ Error fetching favorites: $e");
      emit(FaildToGetFavState());
    }
  }
}
