
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final authService= Provider.of<AuthService>(context);
    final socketService= Provider.of<SocketService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            LogCredentialHeader(isLogin: true,),
      
            const SizedBox(
              height: 30,
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
      
                  LogInInput(
                    label: 'Email', 
                    hintText: '', 
                    icon: Icons.email_rounded, 
                    isPassword: false, 
                    txtController: emailController,
                    inputType: TextInputType.emailAddress,
                  ),
      
                  const SizedBox(
                    height: 20,
                  ),
      
                  LogInInput(
                    label: 'Password', 
                    hintText: '', 
                    icon: Icons.lock, 
                    isPassword: true, 
                    txtController: passwordController
                  ),
      
                  const SizedBox(
                    height: 30,
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
                      final login = await authService.login(
                        emailController.text.trim(), 
                        passwordController.text.trim()
                      );

                      if(login){
                        socketService.connect();
                        Navigator.of(context).pushReplacementNamed('users');
                      }else{
                        showAlert(
                          context, 
                          'Login Failed', 
                          'Check your email and password again.'
                        );
                      }
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text('Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),
                        )
                      )
                    )
                  ),

                  LogRegisterLabels(
                    isLogin: true,
                    route: 'register',
                  ),

                ],
              ),
            ),
            
          ],
        
        ),
      ),
   );
  }
}

class LogRegisterLabels extends StatelessWidget {

  bool isLogin;
  String route;

  LogRegisterLabels({
    Key? key,
    required this.isLogin,
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text( isLogin ? 'Dont you have an account?' : 'Do you already have an account?'),
          GestureDetector(
            onTap: () => Navigator.of(context).pushReplacementNamed(route),
            child: Text( isLogin ? 'Register now for free' : 'Log in now',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogCredentialHeader extends StatelessWidget {

  bool isLogin;

  LogCredentialHeader({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: CustomPaint(
            painter: WaveHeader(),
          ),
        ),
      
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
            child:SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLogin ? 'Welcome back' : 'Register',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    isLogin ? 'Enter your credentials to chat' : 'Create an account to start the chat',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 194, 194, 194),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

