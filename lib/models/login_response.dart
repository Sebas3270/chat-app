import 'dart:convert';

import 'package:chat_app/models/models.dart';

class LoginResponse {
    LoginResponse({
        required this.user,
        required this.token,
    });

    User user;
    String token;

    factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        user: User.fromMap(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
    };
}