import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final authService= Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

            LogCredentialHeader(
              isLogin: false,
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [

                  Column(
                    children: [
                      LogInInput(
                        label: 'Name', 
                        hintText: 'Sebastian Alvarez', 
                        icon: Icons.person, 
                        isPassword: false, 
                        txtController: nameController
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LogInInput(
                        label: 'Email', 
                        hintText: 'example@gmail.com', 
                        icon: Icons.email_rounded, 
                        isPassword: false, 
                        inputType: TextInputType.emailAddress,
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

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: authService.authenticating ? null : () async{
                          FocusScope.of(context).unfocus();
                          final register = await authService.register(
                            nameController.text.trim(),
                            emailController.text.trim(), 
                            passwordController.text.trim()
                          );

                          if(register.isEmpty){
                            Navigator.of(context).pushReplacementNamed('users');
                          }else{
                            showAlert(
                              context, 
                              'Login Failed', 
                              register
                            );
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text('Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                              ),
                            )
                          )
                        )
                      ),

                      
                    ],
                  ),
                ],
              ),
            ),


            LogRegisterLabels(route: 'login', isLogin: false,),
          ],
        ),
      ),
    );
  }
}