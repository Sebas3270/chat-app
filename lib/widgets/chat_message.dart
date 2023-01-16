import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatefulWidget {

  final String id;
  final String message;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.id,
    required this.message,
    required this.animationController,
  }) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: widget.animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: widget.animationController, 
          curve: Curves.easeOut,
        ),
        child: Container(
          child: widget.id == authService.user.id
            ? _sentMessage()
            : _receivedMessage(),
        ),
      ),
    );
  }

  Widget _sentMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(
          right: 12,
          bottom: 5,
          left: 60
        ),
        child: Text(
          widget.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }

  Widget _receivedMessage(){

    final chatAppTheme = Provider.of<ChatAppTheme>(context);

     return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: chatAppTheme.isDarkMode ? Colors.white12 : const Color.fromARGB(255, 215, 215, 215),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(
          left: 12,
          bottom: 5,
          right: 60
        ),
        child: Text(
          widget.message,
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}