import 'dart:convert';

import 'package:chat_app/common/environment.dart';
import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService extends ChangeNotifier {
  late User userTo;

  Future<List<Message>> getChat(String userId) async {
    List<Message> messages = [];

    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/messages/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await AuthService.getToken()}',
          });


      final data = jsonDecode(resp.body);

      for (dynamic message in data) {
        messages.add(Message.fromMap(message));
      }
    } catch (e) {

      print(e);

    } finally {

      return messages;
    }

  }
}
