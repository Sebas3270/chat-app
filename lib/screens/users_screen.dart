import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/services/services.dart';
import 'package:chat_app/models/user.dart';


class UsersScreen extends StatefulWidget {

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final _refreshController = RefreshController(initialRefresh: false);
  final usersService = UsersService();

  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authService.user.name),
        elevation: 0,
        // backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            final authService = Provider.of<AuthService>(context, listen: false);
            await authService.logOut();
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.exit_to_app)
        ),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.check_circle)
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Theme.of(context).primaryColor,),
          waterDropColor: Theme.of(context).primaryColor,
        ),
        onRefresh: _loadUsers,
        child: _listViewUsers(),
      )
   );
  }

  _loadUsers() async{
    users = await usersService.getUsers();
    setState((){});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  ListView _listViewUsers() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) => userListTile(users[index]),  
    );
  }

  ListTile userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        child: Text(user.name.substring(0,2)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.of(context).pushNamed('chat');
      },
    );
  }
}