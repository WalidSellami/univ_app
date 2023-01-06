import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/modules/homeScreen/cubit/Cubit.dart';
import 'package:second_app/modules/homeScreen/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendScreen extends StatelessWidget {

  var recipientController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  sendEmail(String subject , String body , String recEmail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recEmail],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state){},
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
              'Send ViVa Detail',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        defaultFormField(
                            text: 'Subject',
                            controller: subjectController,
                            type: TextInputType.text,
                            prefix: Icons.subject_rounded,
                            validate: (value){
                              if(value == null || value.isEmpty){
                                return 'Subject must not be empty';
                              }else{
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            text: 'Recipient Email',
                            controller: recipientController,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
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
                          height: 25.0,
                        ),
                        TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            label: const Text(
                              'ViVa Detail',
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'ViVa Detail must not be empty';
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                sendEmail(subjectController.text,
                                    messageController.text,
                                    recipientController.text);
                              }
                            },
                            text: 'send',
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
