import 'package:flutter/material.dart';

Future<String?> showCustomDialog(BuildContext context, String title, String description, Function() onYesPressed) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'No'),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              onYesPressed();
              // Handle the "Yes" action here if needed
              Navigator.pop(context, 'Yes');
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
