import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/endPoints.dart';
import 'package:second_app/models/loginModel/LoginModel.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/modules/loginScreen/cubit/States.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialAppState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? login;

  void userLogin({
    required String email,
    required String password,
  }) {

    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
         'password': password,
    }).then((value) {

      // print(value?.data);
      login = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(login!));

    }).catchError((error) {

      print(error.toString());
      emit(LoginErrorState(error));

    });
  }
}
