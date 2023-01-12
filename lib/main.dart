import 'package:chat_app/services/services.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => SocketService(),),
        ChangeNotifierProvider(create: (context) => ChatService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoues,
        theme: ChatAppTheme.lightTheme,
      ),
    );
  }
}