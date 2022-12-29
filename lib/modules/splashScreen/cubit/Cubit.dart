import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/modules/splashScreen/cubit/States.dart';
class SplashCubit extends Cubit<SplashStates>{

  SplashCubit() : super(InitialSplashState());

  static SplashCubit get(context) => BlocProvider.of(context);

  void navigate(context , Widget screen){
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => screen),
              (route) => false);
    });
    emit(SplashNavigateState());
  }


}