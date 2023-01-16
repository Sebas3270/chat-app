import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle){

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w700
        ),
      ),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          textColor: Theme.of(context).primaryColor,
          child: const Text('Ok'),
        ),
      ],
    ),
  );

}