
import 'package:flutter/cupertino.dart';

String? token;

int? id;

var emailCnt = TextEditingController();


// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Form(
//     key: formKey,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         defaultFormField(
//             text: 'Subject',
//             controller: subjectCnt,
//             type: TextInputType.text,
//             prefix: Icons.text_format,
//             validate: (value){}),
//           SizedBox(
//             height: 20.0,
//           ),
//           defaultFormField(
//               text: 'Email',
//               controller: emailCt,
//               type: TextInputType.emailAddress,
//               prefix: Icons.email,
//               validate: (value){}),
//         SizedBox(
//           height: 20.0,
//         ),
//         defaultFormField(
//             text: 'Message',
//             controller: msgCnt,
//             type: TextInputType.text,
//             prefix: Icons.message,
//             validate: (value){}),
//         SizedBox(
//           height: 20.0,
//         ),
//
//         defaultButton(
//              function: () async {
//                // if(formKey.currentState!.validate()) {
//                  formKey.currentState!.save();
//                  try {
//                    sendEmail(subjectCnt.text, msgCnt.text, emailCt.text);
//                  }catch(error){
//                    print(error.toString());
//                  }
//                // }else{
//                //   return null;
//                // }
//              },
//              text: 'send',
//              colorText: Colors.white,
//              context: context)
//       ],
//     ),
//   ),
// ),



// Center(
//   child: defaultTextButton(
//       text: 'log out',
//       onPressed: (){
//         CacheHelper.removeData(key: 'token').then((value) {
//           if(value ?? true){
//             navigatorToNotBack(context: context, screen: LoginScreen());
//           }
//         });
//       }),
// ),


// var subjectCnt = TextEditingController();
// var emailCt = TextEditingController();
// var msgCnt = TextEditingController();
//
// var formKey = GlobalKey<FormState>();
//
// sendEmail(String subject , String body , String recipient) async{
//   final Email email = Email(
//     body: body,
//     subject: subject,
//     recipients: [recipient],
//     isHTML: false,
//   );
//   await FlutterEmailSender.send(email);
// }