import 'package:chat_app/common/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting
} 

class SocketService extends ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  void connect() async {

    final token = await AuthService.getToken();

    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'authentication': token
      }
    });

    _socket.onConnect((_) {
      print('connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onConnectError((data) => print(data));

    _socket.onDisconnect((_){
      print('disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on('new-message',(data){
      print(data);
      notifyListeners();
    });



  }

  void disconnect(){
    _socket.disconnect();
  }
}