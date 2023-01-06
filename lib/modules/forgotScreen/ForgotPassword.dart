import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/modules/forgotScreen/cubit/Cubit.dart';
import 'package:second_app/modules/forgotScreen/cubit/States.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:second_app/shared/components/Constant.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var passwordCnt = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;


  @override
  void initState() {
    passwordCnt.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgotCubit(),
      child: BlocConsumer<ForgotCubit , ForgotStates>(
        listener: (context , state){
          if(state is SuccessForgotState){
            if(state.forgot.status == true) {

              showToast(message: '${state.forgot.message}', state: ToastStates.success);
              navigatorToNotBack(context: context, screen: LoginScreen());

            }else{

              showToast(message: '${state.forgot.message}', state: ToastStates.error);

            }
          }
        },
        builder: (context , state){
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
                'Change Password',
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
                  if(state is LoadingForgotState)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                      ),
                      child: LinearProgressIndicator(
                        color: ThemeCubit.get(context).isDark ? HexColor('198989')  : Colors.blue.shade700,
                      ),
                    ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter your email :',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        defaultFormField(
                            text: 'Email',
                            controller: emailCnt,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must not be empty';
                              }
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return 'Enter a valid email';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Enter your new password :',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        defaultFormField(
                            text: 'Password',
                            controller: passwordCnt,
                            isPassword: isPassword,
                            type: TextInputType.visiblePassword,
                            prefix: Icons.lock_outline,
                            suffix: isPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onPress: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not be empty';
                              }else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                ForgotCubit.get(context).changePassword(
                                    password: passwordCnt.text,
                                );

                                print(emailCnt.text);
                                print(passwordCnt.text);
                              }
                            },
                            text: 'save',
                            colorText: Colors.white,
                            context: context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
