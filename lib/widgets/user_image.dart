import 'package:flutter/material.dart';
import 'package:chat_app/models/models.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return user.image == null
        ? CircleAvatar(
          child: Text(user.name.substring(0,2)),
        )
        : CircleAvatar(
          backgroundImage: NetworkImage(user.image!),
        );
  }
}