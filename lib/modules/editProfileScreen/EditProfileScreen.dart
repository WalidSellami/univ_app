import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:second_app/shared/components/Constant.dart';

class EditProfile extends StatelessWidget {

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){
        if(state is SuccessUpdateProfileAppState){
          if(state.update?.status == true) {

            AppCubit.get(context).getProfile();
            // id = state.update?.user?.id;
            showToast(message: '${state.update?.msg}', state: ToastStates.success);

          }else{

            showToast(message: '${state.update?.msg}', state: ToastStates.error);

          }
        }
      },
      builder: (context , state){

        fNameController.text = (AppCubit.get(context).profile?.firstName).toString();
        lNameController.text = (AppCubit.get(context).profile?.lastName).toString();
        emailController.text = (AppCubit.get(context).profile?.email).toString();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ThemeCubit.get(context).isDark ? Colors.grey.shade900.withOpacity(.3) : Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ThemeCubit.get(context).isDark ? Colors.grey.shade900.withOpacity(.3) : Colors.white,
              statusBarIconBrightness: ThemeCubit.get(context).isDark? Brightness.light : Brightness.dark,
            ),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
              tooltip: 'Back',
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                if(state is LoadingUpdateProfileAppState)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: LinearProgressIndicator(
                      color: ThemeCubit.get(context).isDark ? HexColor('198989')  : Colors.blue.shade700,
                    ),
                  ),
                const SizedBox(
                  height: 5.0,
                ),
                ConditionalBuilder(
                  condition: AppCubit.get(context).profile != null,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        defaultFormField(
                            controller: fNameController,
                            text: 'First Name',
                            type: TextInputType.text,
                            prefix: Icons.person,
                            validate: (value){
                              if(value == null || value.isEmpty){
                                return 'First Name must not be empty';
                              }
                              if(value.length < 2){
                                return 'First Name must be at least 2 characters';
                              }
                              return null;
                            }),

                        const SizedBox(
                          height: 20.0,
                        ),

                        defaultFormField(
                            controller: lNameController,
                            text: 'Last Name',
                            type: TextInputType.text,
                            prefix: Icons.person,
                            validate: (value){
                              if(value == null || value.isEmpty){
                                return 'Last Name must not be empty';
                              }
                              if(value.length < 2){
                                return 'Last Name must be at least 2 characters';
                              }
                              return null;
                            }),

                        const SizedBox(
                          height: 20.0,
                        ),

                        defaultFormField(
                            text: 'Email',
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value){
                              if(value == null || value.isEmpty){
                                return 'Email must not be empty';
                              }
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[[a-zA-Z]+")
                                  .hasMatch(value);
                              if(!emailValid){
                                return 'Enter a valid email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                AppCubit.get(context).updateProfile(
                                    firstName: fNameController.text,
                                    lastName: lNameController.text,
                                    email: emailController.text);
                              }
                            },
                            text: 'update',
                            colorText: Colors.white,
                            context: context)
                      ],
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.blue.shade700,)),
                ),
              ],
            ),
          ),
        );

      },
    );
  }
}
