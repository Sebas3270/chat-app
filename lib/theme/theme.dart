import 'package:flutter/material.dart';

class ChatAppTheme {

  static final lightTheme = ThemeData(
    fontFamily: 'DmSans',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF0165ff),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    // fontFamily: 'DmSans',
    scaffoldBackgroundColor: Color.fromARGB(255, 29, 29, 29),
    primaryColor: Color(0xFF0165ff),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.white,
    )
  );

}