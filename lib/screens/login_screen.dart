import 'package:chat_app/widgets/login_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInScreen extends StatelessWidget {

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
                        'Login',
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
                        isLogin: true,
                        onTapFunction: () {
                          print('Hi');
                        },
                      ),

                      
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40,),

            LogInRegisterLabels(route: 'register', isLogin: true,),
          ],
        ),
      ),
    );
  }
}

class LogInRegisterLabels extends StatelessWidget {

  final bool isLogin;
  final String route;

  LogInRegisterLabels({
    Key? key,
    required this.route,
    required this.isLogin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(isLogin ? 'Dont you have an account?' : 'Already an account?', 
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed(route),
          child: Text(isLogin ? 'Register here' : 'Log In here', 
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).primaryColor
            ),
          ),
        ),
      ],
    );
  }
}

class TopImageContainer extends StatelessWidget {
  const TopImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/login.jpg'),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.centerStart,
          colorFilter: ColorFilter.mode(Color.fromARGB(255, 0, 0, 0).withOpacity(0.6), BlendMode.darken),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  void Function() onTapFunction;
  final bool isLogin;

  LoginButton({
    Key? key,
    required this.onTapFunction,
    required this.isLogin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          height: 55,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? 'Log In' : 'Register',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
