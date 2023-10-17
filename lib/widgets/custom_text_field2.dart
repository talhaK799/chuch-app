import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  Widget? prefixIcon;
  bool readOnly;
  Function()? onTap;
  Widget? suffixIcon;

  CustomTextField2({
    required this.labelText,
    required this.hintText,
    this.maxLines,
    this.onTap,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    required this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onTap: onTap,
        // autovalidateMode: AutovalidateMode.,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
      ),
    );
  }
}
