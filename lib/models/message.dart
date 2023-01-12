// To parse this JSON data, do
//
//     final message = messageFromMap(jsonString);

import 'dart:convert';

class Message {
    Message({
        required this.id,
        required this.from,
        required this.to,
        required this.message,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["_id"],
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
