import 'dart:io';

import 'package:chat_app/services/services.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final appTheme = Provider.of<ChatAppTheme>(context);
    final screenService = Provider.of<ScreenService>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text('Dark mode'),
              contentPadding: EdgeInsets.zero,
              value: appTheme.isDarkMode, 
              onChanged: (value) => appTheme.isDarkMode = value,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Log out'),
              trailing: const Icon(
                Icons.exit_to_app_rounded
              ),
              onTap: () async {

                if(Platform.isAndroid){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Logging out"),
                        content: const Text("Would you like to log out of the app?"),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: (){
                              Navigator.of(context).pop();
                              return;
                            },
                          ),
                          TextButton(
                            child: const Text('Continue'),
                            onPressed: ()async{

                              final authService = Provider.of<AuthService>(context, listen: false);
                              await authService.logOut();
                              socketService.disconnect();
                              Navigator.pushReplacementNamed(context, 'login');
                              screenService.currentIndex = 0;

                            },
                          ),
                        ],
                      );
                    },
                  );
                }else{
                  showDialog(
                    context: context, 
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Logging out"),
                      content: const Text("Would you like to log out of the app?"),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          
                          child: const Text("Yes"),
                          onPressed: ()async{

                            final authService = Provider.of<AuthService>(context, listen: false);
                            await authService.logOut();
                            socketService.disconnect();
                            Navigator.pushReplacementNamed(context, 'login');
                            screenService.currentIndex = 0;

                          },
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            return;
                          },
                        )
                      ],
                    ),
                  );
                  
                }
              },
            )
          ],
        ),
      ),
    );
  }


  
}

class TopBarProfile extends StatelessWidget {
  const TopBarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          authService.user.name,
          style: const TextStyle(
            fontSize: 33,
            // color: Colors.black,
            fontWeight: FontWeight.w700
          ),
        ),
        CircleAvatar(
          child: Text(authService.user.name.substring(0,2)),
        )
      ],
    );
  }
}