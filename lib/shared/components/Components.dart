import 'package:flutter/material.dart';

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

Widget defaultTextButton({
  required String text,
  required Function onPressed,
}) => TextButton(
    onPressed: (){
     onPressed();
 },
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.5,
        color: Colors.blue.shade700,
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
        color: Colors.blue.shade700,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: colorText, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );


Future navigatorTo({required BuildContext context, required Widget screen}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

Future navigatorToNotBack(
    {required BuildContext context, required Widget screen}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
          (route) => false,
    );
