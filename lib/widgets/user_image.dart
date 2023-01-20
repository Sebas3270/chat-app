import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/models.dart';

class UserImage extends StatefulWidget {
  UserImage({
    Key? key,
    required this.user,
    this.onTapFunction
  }) : super(key: key);

  final User user;
  void Function()? onTapFunction;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapFunction,
      child: widget.user.image == null ? CircleAvatar(
          child:  Text(widget.user.name.substring(0,2)),
        ): CircleAvatar(
          backgroundColor: isError ? Theme.of(context).primaryColor : Colors.transparent,
          child: SizedBox(
            width: 40,
            height: 40,
            child: ClipOval(
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.user.image!,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error){
                    isError = true;
                    return Center(child: Text(widget.user.name.substring(0,2)));
                  },
              ),
            ),
          ),
        ),
    );
  }
}