import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
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

  final List<ChatMessage> _messages = [];

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
        toolbarHeight: 70,
        elevation: 0,
        title: Row(
          children: [
            UserImage(user: chatService.userTo),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  chatService.userTo.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                ),
                Text(
                  chatService.userTo.online ? 'Online' : 'Offline',
                  style: const TextStyle(
                    // color: Colors.black45,
                    fontSize: 14
                  ),
                ),
              ],
            ),
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
          icon: const Icon(
            FluentSystemIcons.ic_fluent_chevron_left_filled,
            // color: Colors.black54,
          ),
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

            const Divider(
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
              icon: const Icon(Icons.send),
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