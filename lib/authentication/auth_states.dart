abstract class AuthStates {}
class AuthInitialStates extends AuthStates {}
class RegisterLoadingStates extends AuthStates {}
class FailedToRegisterStates extends AuthStates {
  final String message;
  FailedToRegisterStates({required this.message});
}
class RegisterSuccesStates extends AuthStates {}
class LoginLoadingStates extends AuthStates {}
class FailedToLoginStates extends AuthStates {
  final String message;
  FailedToLoginStates({required this.message});
}
class LoginSuccesStates extends AuthStates {}



class ApiLoadingStates extends AuthStates {}
class ApiSuccessStates extends AuthStates {
  final dynamic data;
  ApiSuccessStates({required this.data});
}
class ApiFailedStates extends AuthStates {
  final String message;
  ApiFailedStates({required this.message});

}