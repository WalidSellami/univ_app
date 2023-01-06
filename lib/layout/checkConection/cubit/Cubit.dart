
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:second_app/layout/checkConection/cubit/States.dart';



// This is for check connection internet when the host become https we use it like a new feature.

class CheckCubit extends Cubit<CheckStates> {

  CheckCubit() : super(InitialCheckState());

  static CheckCubit get(context) => BlocProvider.of(context);


  bool hasInternet = false;

  void checkConnection(){

    InternetConnectionChecker().onStatusChange.listen((status) {

      hasInternet = status == InternetConnectionStatus.connected;

      hasInternet = hasInternet;

      hasInternet ? showSimpleNotification(

        Row(
          children: const [
            Text(
              'You are not connected',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.wifi_outlined,
              color: Colors.white,
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        background: Colors.teal,
      ) : showSimpleNotification(

        Row(
          children: const [
            Text(
              'You are not connected',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
                Icons.wifi_off_outlined,
                color: Colors.white,
              ),
          ],
        ),
        duration: const Duration(seconds: 2),
        background: Colors.red,
      );

      emit(CheckConnectionState());

    });

  }

}