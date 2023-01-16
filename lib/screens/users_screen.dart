import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
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
    final screenService = Provider.of<ScreenService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: IndexedStack(
          index: screenService.currentIndex,
          children: const [
            TopBarUserChats(),
            TopBarProfile()
          ],
        ),
        elevation: 0,
      ),
      body: IndexedStack(
        index: screenService.currentIndex,
        children: [
          SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: Theme.of(context).primaryColor,),
              waterDropColor: Theme.of(context).primaryColor,
            ),
            onRefresh: _loadUsers,
            child: _listViewUsers(),
          ),
    
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        currentIndex: screenService.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FluentSystemIcons.ic_fluent_chat_regular,
            ),
            // activeIcon: Icon(FluentSystemIcons.ic_fluent_chat_filled),
            label: 'Chat'
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            // activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: 'Home'
          ),
        ],
        onTap: (value) {
          screenService.currentIndex = value;
        },
      ),
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
      leading: user.online 
      ? Stack(
        children: [
          UserImage(user: user),
          const Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      )
      : UserImage(user: user),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.of(context).pushNamed('chat');
      },
    );
  }
}

class TopBarUserChats extends StatelessWidget {
  
  const TopBarUserChats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Messages',
          style: TextStyle(
            fontSize: 33,
            // color: Colors.black,
            fontWeight: FontWeight.w700
          ),
        ),
        UserImage(user: authService.user)
      ],
    );
  }
}