import 'dart:convert';

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.online,
        this.image
    });

    String id;
    String name;
    String email;
    bool online;
    String? image;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        online: json["online"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "online": online,
        "image": image
    };
}