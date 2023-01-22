import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatAppTheme extends ChangeNotifier{

  static late SharedPreferences _prefs;
  ThemeData currentTheme = customLightTheme;

  static bool _isDarkMode = false;

  ChatAppTheme(){
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    isDarkMode = _prefs.getBool('themePreference') ?? false;
  }

  bool get isDarkMode {
    _isDarkMode = _prefs.getBool('themePreference') ?? false;
    return _isDarkMode;
  }

  set isDarkMode(bool value){
    _isDarkMode = value;
    _prefs.setBool('themePreference', value);

    currentTheme = _isDarkMode
    ? customDarkTheme
    : customLightTheme;

    notifyListeners();   
  }

  static final customLightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'DmSans',
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue[900],

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'DmSans'
      ),
      iconTheme: IconThemeData(
        color: Colors.black54
      )
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(fontWeight: FontWeight.w400, color:Colors.grey[600]),
      prefixIconColor: Colors.grey[350],
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 215, 215, 215), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 215, 215, 215), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
    )
  );

  Color primaryBlackColor = Colors.black;

  static final customDarkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'DmSans',
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
    
    primaryColor: const Color(0xFF0165ff),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 29, 29, 29),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'DmSans',
      ),
      iconTheme: IconThemeData(
        color: Colors.white54
      )
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 29, 29, 29),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white38
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      fillColor: const Color.fromARGB(255, 56, 56, 56),
      filled: true,
      labelStyle: TextStyle(fontWeight: FontWeight.w400, color:Color.fromARGB(255, 170, 170, 170)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
    )
  );

}