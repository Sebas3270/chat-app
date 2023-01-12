import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin  {

  final _chatTextController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _messages = [];

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false); 
    socketService = Provider.of<SocketService>(context, listen: false);  
    authService = Provider.of<AuthService>(context, listen: false); 

    socketService.socket.on('private-message', _onReceivedMessage);

    _loadPreviousMessages(chatService.userTo.id);

  }

  Future _loadPreviousMessages( String userId ) async {
    List<Message> messages = await chatService.getChat(userId);
    
    final previousMessages = messages.map((message) => ChatMessage(
      id: message.from, 
      message: message.message, 
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      )..forward(),
    )).toList();

    setState(() {
      _messages.insertAll(0, previousMessages);
    });
  }

  void _onReceivedMessage( dynamic data ){
    print('Got a message: $data');

    final message = ChatMessage(
      id: data['from'], 
      message: data['message'], 
      animationController: AnimationController(
        vsync: this,
        duration: const Duration( milliseconds: 300)
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            CircleAvatar(
              // backgroundImage: NetworkImage('https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
              child: Text(chatService.userTo.name.substring(0,2)),
            ),
            SizedBox(width: 20),
            Text(chatService.userTo.name),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            if( Navigator.of(context).canPop() ){
              Navigator.of(context).pop();
            }else{
              Navigator.of(context).pushNamed('users');
            }
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

            SizedBox(
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
      id: authService.user.id, 
      message: value, 
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

    socketService.socket.emit('private-message', {
      'from': authService.user.id,
      'to': chatService.userTo.id,
      'message': value
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
                decoration: const InputDecoration.collapsed(
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

    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }

    socketService.socket.off('private-message');
    super.dispose();
  }
}