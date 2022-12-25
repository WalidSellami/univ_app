import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/modules/loginScreen/cubit/Cubit.dart';
import 'package:second_app/modules/loginScreen/cubit/States.dart';
import 'package:second_app/modules/registerScreen/RegisterScreen.dart';
import 'package:second_app/shared/components/Components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
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
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'login'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontSize: 35.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login now to continue',
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
                              text: 'Email',
                              controller: emailController,
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
                            height: 20.0,
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
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultButton(
                              text: 'login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  print(emailController.text);
                                  print(passwordController.text);
                                }
                              },
                              colorText: Colors.white,
                              context: context),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              defaultTextButton(
                                  text: 'register',
                                  onPressed: () {
                                    navigatorTo(
                                        context: context,
                                        screen: const RegisterScreen());
                                  }),
                            ],
                          ),
                        ],
                      ),
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
