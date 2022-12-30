import 'package:flutter/material.dart';

class LogInInput extends StatelessWidget {

  String label;
  String hintText;
  IconData icon;
  bool isPassword;
  TextEditingController txtController;

  LogInInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.txtController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          obscureText: isPassword,
          decoration:
          inputDecoration(label, hintText, icon)
        ),
    );
  }

    final Color primary = Color.fromARGB(255, 193, 193, 193);
  InputDecoration inputDecoration(
      String label, String hintText, IconData icon) {
      return InputDecoration(
        label: Text(label),
        hintText: hintText,
        focusColor: const Color(0xFF0165ff),
        prefixIcon: Icon(
          icon,
        ),
        floatingLabelStyle: TextStyle(
          color: Color(0xFF0165ff),
          // fontWeight: FontWeight.w600
        ),
        labelStyle: TextStyle(
          color: primary,
          // fontWeight: FontWeight.w600
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0165ff), width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );
  }
}
