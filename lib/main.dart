import 'package:chat_app/services/services.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatAppTheme(),),
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => SocketService(),),
        ChangeNotifierProvider(create: (context) => ChatService(),),
        ChangeNotifierProvider(create: (context) => ScreenService(),),
      ],
      child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final chatAppTheme = Provider.of<ChatAppTheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: chatAppTheme.currentTheme,
      title: 'Material App',
      initialRoute: 'loading',
      routes: appRoues,
    );
  }
}