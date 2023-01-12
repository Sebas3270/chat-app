import 'dart:convert';

import 'package:chat_app/common/environment.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';

import 'package:http/http.dart' as http;

class UsersService{

  Future<List<User>> getUsers() async {

    List<User> users = [];

    try {

      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/auth/users'), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await AuthService.getToken()}',
        }
      );

      // List<dynamic> parsedListJson = jsonDecode(resp.body);
      // users = List<User>.from(parsedListJson.map<User>((dynamic i) => User.fromJson(i)));

      final data = jsonDecode(resp.body);

      for (dynamic user in data) {
        users.add(User.fromMap(user));
      }

      print(data);
      
    } catch (e) {
      print(e);
    } finally {
      return users;
    }
  }

}