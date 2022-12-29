import 'package:second_app/models/registerModel/RegisterModel.dart';

abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel register;
  RegisterSuccessState(this.register);
}

class RegisterErrorState extends RegisterStates {}