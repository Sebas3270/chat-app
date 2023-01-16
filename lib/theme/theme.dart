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
        color: Colors.black
      ),
      iconTheme: IconThemeData(
        color: Colors.black54
      )
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
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
        color: Colors.white
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
  );

}