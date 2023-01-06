import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/appLayout/MainScreen.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/States.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/modules/homeScreen/cubit/Cubit.dart';
import 'package:second_app/modules/registerScreen/cubit/Cubit.dart';
import 'package:second_app/modules/registerScreen/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/local/CacheHelper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isPassword = true;


  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit , RegisterStates>(
            listener: (context , state){
              if(state is RegisterSuccessState){
                if(state.register.status == true){
                  print(state.register.message);
                  print(state.register.data?.original?.token);

                  showToast(message: '${state.register.message}', state: ToastStates.success);
                  CacheHelper.saveData(key: 'token', value: '${state.register.data?.original?.token}').then((value) {

                    token = state.register.data?.original?.token;

                    CacheHelper.saveData(key: 'id', value: '${state.register.user?.id}').then((value) {
                      id = state.register.user?.id;
                    });

                    navigatorToNotBack(context: context, screen: MainScreen());
                    AppCubit.get(context).getProfile();
                    // HomeCubit.get(context).getDetails();

                  });

                }else{

                  showToast(message: '${state.register.message}', state: ToastStates.error);

                }
              }
            },
            builder: (context , state){
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ThemeCubit.get(context).isDark ? Colors.grey.shade900 : Colors.white,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    tooltip: 'Back',
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'register'.toUpperCase(),
                              style: Theme.of(context).textTheme.headline4?.copyWith(
                                fontSize: 34.0,
                                color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Register now to join',
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),

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
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                                text: 'Password',
                                controller: passwordController,
                                isPassword: isPassword,
                                type: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                suffix: isPassword ? Icons.visibility_off : Icons.visibility,
                                onPress: (){
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                                validate: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Password must not be empty';
                                  }
                                  if(value.length < 8){
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) =>  defaultButton(
                                  text: 'register',
                                  function: (){
                                    if(formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                            firstName: fNameController.text,
                                            lastName: lNameController.text,
                                            email: emailController.text,
                                            password: passwordController.text);

                                        print(emailController.text);
                                        print(passwordController.text);
                                    }
                                  },
                                  colorText: Colors.white,
                                  context: context),
                              fallback: (context) => Center(child: CircularProgressIndicator(color: ThemeCubit.get(context).isDark? HexColor('198989') : Colors.blue.shade700,)),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }
}
