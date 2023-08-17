import 'package:churchappenings/utils/extention.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  CustomTextFormFeild(
      {this.controller,
      this.labelText,
      this.onChanged,
      this.validator,
      this.type,
      super.key});
  String? labelText;
  final onChanged;
  final controller;
  final validator;
  final type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$labelText"),
        5.height,
        TextFormField(
          // enabled: false,
          keyboardType: type,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
