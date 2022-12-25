import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/modules/splashScreen/SplashScreen.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';
import 'package:second_app/shared/styles/Styles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // DioHelper.init();

  // var responce = await Dio().get('http://10.0.2.2/...');
  // print(responce.data);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: lightTheme,
      // darkTheme: darkTheme,
      home: SplashScreen(),
    );
  }
}
