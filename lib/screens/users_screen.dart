import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/user.dart';


class UsersScreen extends StatefulWidget {

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(uuid: '1', nombre: 'David', email: 'example@gmail.com', online: true),
    User(uuid: '2', nombre: 'Carlos', email: 'example2@gmail.com', online: true),
    User(uuid: '3', nombre: 'Alexis', email: 'example3@gmail.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sebastian'),
        elevation: 0,
        // backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            
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
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
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
          title: Text(user.nombre),
          leading: CircleAvatar(
            child: Text(user.nombre.substring(0,2)),
          ),
        );
  }
}