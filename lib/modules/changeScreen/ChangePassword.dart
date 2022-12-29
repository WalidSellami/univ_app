import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';

class ChangePassword extends StatefulWidget {

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;


  @override
  void initState() {
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){
        if(state is SuccessChangePassAppState){
          if(state.change.status == true) {

            showToast(message: '${state.change.message}', state: ToastStates.success);
            Navigator.pop(context);

          }else{

            showToast(message: '${state.change.message}', state: ToastStates.error);

          }
        }
      },
      builder: (context , state){
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                        tooltip: 'Back',
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if(state is LoadingChangePassAppState)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                      ),
                      child: LinearProgressIndicator(
                        color: Colors.blue.shade700,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter your new password :',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            text: 'Password',
                            controller: passwordController,
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
                               AppCubit.get(context).changePassword(
                                  password: passwordController.text,
                                );

                                print(passwordController.text);
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
          ),
        );

      },
    );
  }
}
