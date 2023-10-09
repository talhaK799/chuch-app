import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? buttonColor;
  final String buttonText;
  final Color? buttonTextColor;

  CustomElevatedButton({
    required this.onPressed,
    this.height,
    this.width,
    this.buttonColor,
    required this.buttonText,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          primary: buttonColor ?? redColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              color: buttonTextColor ??
                  Colors.white), // Default text color if not provided
        ),
      ),
    );
  }
}
