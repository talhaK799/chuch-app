import 'package:flutter/material.dart';



void showSnackbar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.grey,
  Duration duration = const Duration(seconds: 2),
  String actionLabel = '',
  VoidCallback? actionCallback,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
      action: actionLabel.isNotEmpty
          ? SnackBarAction(
              label: actionLabel,
              onPressed: actionCallback ?? () {},
            )
          : null,
    ),
  );
}
