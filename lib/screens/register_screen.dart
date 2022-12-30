import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

            const TopImageContainer(),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Column(
                    children: [
                      LogInInput(
                        label: 'Name', 
                        hintText: 'Sebastian Alvarez', 
                        icon: Icons.person, 
                        isPassword: false, 
                        txtController: emailController
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LogInInput(
                        label: 'Email', 
                        hintText: 'example@gmail.com', 
                        icon: Icons.email_rounded, 
                        isPassword: false, 
                        txtController: emailController
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LogInInput(
                        label: 'Password', 
                        hintText: '********', 
                        icon: Icons.lock, 
                        isPassword: true, 
                        txtController: passwordController
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      LoginButton(
                        isLogin: false,
                        onTapFunction: () {
                          print('Hi');
                        },
                      ),

                      
                    ],
                  ),
                ],
              ),
            ),


            LogInRegisterLabels(route: 'login', isLogin: false,),
          ],
        ),
      ),
    );
  }
}