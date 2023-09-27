import 'package:flutter/material.dart';

class RectangularIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;
  final Color buttonColor; // Add a property for custom button color

  const RectangularIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.buttonColor = Colors.blue, // Default button color is blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon,color: Colors.white,),
        label: Text(label,style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          primary: buttonColor, // Set the button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
