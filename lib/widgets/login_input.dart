import 'package:flutter/material.dart';

class LogInInput extends StatelessWidget {

  String label;
  String hintText;
  IconData icon;
  bool isPassword;
  TextEditingController txtController;
  TextInputType inputType;

  LogInInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.txtController,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txtController,
      obscureText: isPassword,
      keyboardType: inputType,
      cursorColor: Colors.grey[500],
      style: const TextStyle(
        fontWeight: FontWeight.w700
      ),
      decoration: InputDecoration(
        label: Text(label),
        // hintText: 'example@gmail.com',
        prefixIcon: Icon(icon, color: Colors.grey[350],),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Color.fromARGB(255, 215, 215, 215), width: 2.0),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        // focusedBorder:OutlineInputBorder(
        //   borderSide: const BorderSide(color: Color.fromARGB(255, 215, 215, 215), width: 2.0),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
    );
  }

  //   final Color primary = Color.fromARGB(255, 193, 193, 193);
  // InputDecoration inputDecoration(
  //     String label, String hintText, IconData icon) {
  //     return InputDecoration(
  //       label: Text(label),
  //       hintText: hintText,
  //       focusColor: const Color(0xFF0165ff),
  //       prefixIcon: Icon(
  //         icon,
  //       ),
  //       floatingLabelStyle: TextStyle(
  //         color: Color(0xFF0165ff),
  //         // fontWeight: FontWeight.w600
  //       ),
  //       labelStyle: TextStyle(
  //         color: primary,
  //         // fontWeight: FontWeight.w600
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(10)),
  //         borderSide: BorderSide(color: primary, width: 1.5),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: primary, width: 1.5),
  //         borderRadius: BorderRadius.all(Radius.circular(10)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Color(0xFF0165ff), width: 1.5),
  //         borderRadius: BorderRadius.all(Radius.circular(10)),
  //       ),
  //     );


  final Color primary = const Color.fromARGB(255, 193, 193, 193);
  InputDecoration inputDecoration(
      String label, String hintText, IconData icon) {
      return InputDecoration(
        label: Text(label),
        hintText: hintText,
        focusColor: const Color(0xFF0165ff),
        prefixIcon: Icon(
          icon,
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF0165ff),
          // fontWeight: FontWeight.w600
        ),
        labelStyle: TextStyle(
          color: primary,
          // fontWeight: FontWeight.w600
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          // borderSide: BorderSide(color: Color(0xFF0165ff), width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );

  }
}
