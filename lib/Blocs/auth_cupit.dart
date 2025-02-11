import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Blocs/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());


  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required int avaterId,
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
          "avaterId": avaterId.toInt()
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

  
}
