import 'package:chat_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder( 
        future: checkLogInState(context),
        builder: (context, snapshot) => const Center(
          child: Text('Loading...'),
        ),
      ),
   );
  }

  Future checkLogInState(BuildContext context) async {
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService= Provider.of<SocketService>(context, listen: false);
    final authenticated = await authService.isLogged();

    if(authenticated){
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'users');
    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}