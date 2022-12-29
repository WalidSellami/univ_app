import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = AppCubit.get(context);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'No Projects Added',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Press on the button to add projects',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

  }
}
