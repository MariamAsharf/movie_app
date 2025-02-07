import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_app/authentication/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required int avatarId,
  }) async {
    emit(RegisterLoadingStates());
    Response response = await http.post(
      Uri.parse("https://route-movie-apis.vercel.app/auth/register"),
      body: jsonEncode(
        {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "confirmPassword": confirmPassword,
          "avatarId": avatarId
        },
      ),
    );
    var resposeBody = jsonDecode(response.body);
    if (resposeBody['status'] == 201) {
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
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 200) {
          debugPrint("User Login Success And His Data is: $data");
          emit(LoginSuccesStates());
        } else {
          debugPrint("Failed To Login , Reason is: ${data['message']}");

          emit(
            FailedToLoginStates(
              message: data['message'],
            ),
          );
        }
      }
    } catch (e) {
      emit(
        FailedToLoginStates(
          message: e.toString(),
        ),
      );
    }
  }
 }
