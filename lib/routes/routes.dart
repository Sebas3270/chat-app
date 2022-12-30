import 'package:chat_app/screens/screens.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoues = {
  'users': (context) => UsersScreen(),
  'chat': (context) => ChatScreen(),
  'login': (context) => LogInScreen(),
  'register': (context) => RegisterScreen(),
  'loading': (context) => LoadingScreen(),
};

