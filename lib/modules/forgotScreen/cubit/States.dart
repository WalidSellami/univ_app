import 'package:second_app/models/forgotModel/ForgotModel.dart';

abstract class ForgotStates {}

class InitialForgotState extends ForgotStates {}

class LoadingForgotState extends ForgotStates {}

class SuccessForgotState extends ForgotStates {
  final ForgotModel forgot;
  SuccessForgotState(this.forgot);
}

class ErrorForgotState extends ForgotStates {
  final String error;
  ErrorForgotState(this.error);
}