import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/modules/splashScreen/cubit/Cubit.dart';
import 'package:second_app/modules/splashScreen/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';

class SplashScreen extends StatefulWidget {

  Widget? widget;
  SplashScreen(this.widget);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this , duration: const Duration(milliseconds: 500));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashCubit()..navigate(context, widget.widget!),
      child: BlocConsumer<SplashCubit , SplashStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ThemeCubit.get(context).isDark ? Colors.grey.shade900 : Colors.white,
              // systemOverlayStyle: const SystemUiOverlayStyle(
              //   statusBarColor: Colors.white,
              //   statusBarIconBrightness: Brightness.dark,
              // ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context , widget) => Transform.scale(
                        scale: animationController.value,
                        child: Opacity(
                          opacity: animationController.value,
                          child: Image.asset('images/viva.png',
                            width: 150.0,
                            height: 150.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SpinKitThreeBounce(
                  color: Colors.blue.shade700,
                  size: 35.0,
                ),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
