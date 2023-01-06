import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/layout/appLayout/MainScreen.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/Cubit.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/layout/darkMode/cubit/States.dart';
import 'package:second_app/modules/homeScreen/cubit/Cubit.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/modules/splashScreen/SplashScreen.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/local/CacheHelper.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';
import 'package:second_app/shared/styles/Styles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  // var responce = await Dio().get('http://10.0.2.2/api/users/1');
  // print(responce.data);

  // var responce = await Dio().delete('http://10.0.2.2/api/delete/3');
  // print(responce.data);

  token = CacheHelper.getData(key: 'token');
  print(token);
  id = CacheHelper.getData(key: 'id');
  print(id);

  bool? isDark = CacheHelper.getData(key: 'isDark');


  Widget? widget;

  if(token != null){
    widget = MainScreen();
  }else{
    widget = LoginScreen();
  }

  runApp(MyApp(startWidget: widget, isDark: isDark,));
}

class MyApp extends StatelessWidget {

  final Widget? startWidget;
  final bool? isDark;
  MyApp({this.startWidget , this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getProfile()
        ),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()..getDetails()
        ),
        BlocProvider(
           create: (BuildContext context) => ThemeCubit()..changeTheme(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ThemeCubit , ThemeStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreen(startWidget),
          );

        },
      ),
    );
  }
}
