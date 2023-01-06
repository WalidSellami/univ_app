import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';

Widget defaultFormField({
  required String text,
  required TextEditingController controller,
  required TextInputType type,
  required IconData prefix,
  required String? Function(String?)? validate,
  bool isPassword = false,
  IconData? suffix,
  Function? onPress,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  style: const TextStyle(
    fontWeight: FontWeight.bold,
  ),
  decoration: InputDecoration(
    label: Text(
      text,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: (suffix!=null) ? ((controller.text.isNotEmpty) ? IconButton(
        onPressed: (){
          onPress!();
        },
        icon: Icon(suffix)) : null): null,
  ),
  validator: validate,
);


// TextFormField without prefix icon we use it on HomeScreen (Fill The Form)
Widget defaultSimpleFormField({
  required String text,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  String? helperText,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  style: const TextStyle(
    fontWeight: FontWeight.bold,
  ),
  decoration: InputDecoration(
    label: Text(
      text,
    ),
    helperText: helperText,
    helperStyle: const TextStyle(
      color: Colors.red,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  validator: validate,
);


Widget defaultTextButton({
  required String text,
  required Function onPressed,
  context,
}) => TextButton(
    onPressed: (){
     onPressed();
 },
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.5,
        color: ThemeCubit.get(context).isDark ?  HexColor('35c2c2') : Colors.blue.shade700,
      ),
    ),
);


Widget defaultButton({
  double width = double.infinity,
  double height = 48.0,
  required Function function,
  required String text,
  Color? colorText,
  required BuildContext context,
}) =>
    SizedBox(
      width: width,
      child: MaterialButton(
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          function();
        },
        color: ThemeCubit.get(context).isDark ? HexColor('198989') : Colors.blue.shade700,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: colorText, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );

// Navigator to another screen and we can return to precedent screen
Future navigatorTo({required BuildContext context, required Widget screen}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

// Navigator to another screen and we can't return to precedent screen (we use it on LoginScreen , RegisterScreen ...)
Future navigatorToNotBack(
    {required BuildContext context, required Widget screen}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
          (route) => false,
    );

// Simple notification
void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(s: state),
      textColor: Colors.white,
      fontSize: 17.0,
    );

// States of notification
enum ToastStates {success , error , warning}

Color chooseToastColor({
  required ToastStates s,
  context,
}) {
  Color? color;
  switch (s) {
    case ToastStates.success:
     color = HexColor('198989');
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget defaultElevatedButton({
  required String text,
  required Function onPress,
  Color? color,
}) => ElevatedButton(
    onPressed: (){
      onPress();
    },
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(
      color,
    ),
    minimumSize: const MaterialStatePropertyAll(
      Size(120 , 45),
    )
  ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18.5,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
 );


