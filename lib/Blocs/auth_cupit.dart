import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/Blocs/auth_states.dart';

import '../Network/local_network.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  final dio = Dio();


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
      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confirmPassword": confirmPassword,
        "avaterId": avaterId
      };

      var response = await dio.post(
        "https://route-movie-apis.vercel.app/auth/register",
        data: body,
      );

      if (response.statusCode == 201) {
        emit(RegisterSuccesStates());
      } else {
        emit(FailedToRegisterStates(message: response.data['message']));
      }
    } catch (e) {
      emit(FailedToRegisterStates(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingStates());

    try {
      var response = await dio.post(
        "https://route-movie-apis.vercel.app/auth/login",
        data: {"email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

     // var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(LoginSuccesStates());
        CashNetwork.insertsToCash(key: "token", value: response.data);

      } else {
        emit(FailedToLoginStates(message: response.data['message']));
      }
    } catch (e) {
      emit(FailedToLoginStates(message: e.toString()));
    }
  }
}
