import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_app/authentication/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rePassword,
  }) async {
    emit(RegisterLoadingStates());
    Response response = await http.post(
        Uri.parse("https://route-movie-apis.vercel.app/auth/register"),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "re_password": rePassword,
        });
    var resposeBody = jsonDecode(response.body);
    if (resposeBody['states'] == true) {
      print(resposeBody);
      emit(RegisterSuccesStates());
    } else {
      print(resposeBody);
      emit(
        FailedToRegisterStates(
          message: resposeBody['message'],
        ),
      );
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingStates());
    try {
      Response response = await http.post(
          Uri.parse("https://route-movie-apis.vercel.app/auth/login"),
          body: {
            "email": email,
            "password": password,
          });
      if (response.statusCode == 200) 
      {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("User Login Success And His Data is: $data");
          emit(LoginSuccesStates());
        } else {
          debugPrint("Failed To Login , Reason is: ${data['message']}");

          emit(FailedToLoginStates(message: data['message']));
        }
      }
    } 
    catch (e) {
      emit(FailedToLoginStates(message: e.toString()));
    }
  }
}
