import 'package:second_app/models/loginModel/LoginModel.dart';

abstract class LoginStates{}

class InitialAppState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  // final LoginModel login;
  // SuccessAppState(this.login);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}