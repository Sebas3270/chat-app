import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle){

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w700
        ),
      ),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          textColor: Theme.of(context).primaryColor,
          child: Text('Ok'),
        ),
      ],
    ),
  );

}