import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin  {

  final _chatTextController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _messages = [
    // ChatMessage(uuid: '1', text: 'Hi, I miss you'),
    // ChatMessage(uuid: '2', text: 'Hi, I miss you more'),
    // ChatMessage(uuid: '2', text: 'Hi, I miss you'),
    // ChatMessage(uuid: '2', text: 'Hi, I miss you more'),
    // ChatMessage(uuid: '1', text: 'Hi, I miss you'),
    // ChatMessage(uuid: '2', text: 'Hi, I miss you more'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
            ),
            SizedBox(width: 20),
            Text('Melisa'),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            
          }, 
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
                reverse: true,
              ),
            ),

            Divider(
              height: 1,
            ),

            Container(
              height: 70,
              child: _chatTextBox(),
            )
          ],
        )
      ),
   );
  }

  void _handleSubmit( String value) {

    if (value.isEmpty){
      return;
    }

    _chatTextController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uuid: '1', 
      text: value, 
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      )
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  Widget _chatTextBox() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _chatTextController,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    _isWriting = value.trim().isNotEmpty;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Send message'
                ),
              ),
            ),

            IconButton(
              splashColor: Colors.transparent,  
              highlightColor: Colors.transparent,
              icon: Icon(Icons.send),
              onPressed: _isWriting
                ? () => _handleSubmit( _chatTextController.text.trim() )
                : null
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: socket off

    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }

    super.dispose();
  }
}