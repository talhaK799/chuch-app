// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String text;
  final String? Function(String?)? validator;
  final String hintText;

  final String? selectedValue;
  final void Function(String?) onChanged;
  List<DropdownMenuItem<String>>? mitems;

  CustomDropdownField({
    required this.hint,
    required this.text,
    required this.validator,
    required this.hintText,
    required this.selectedValue,
    required this.onChanged,
    required this.mitems,
  });


@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
     
      child:    DropdownButtonFormField<String>(
            
            hint: Text(hint),
              
            
            
            value: selectedValue,
            onChanged: onChanged,
            icon: Icon(Icons.arrow_drop_down_circle_sharp),
            items: mitems,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: redColor),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: validator,
          ),
        
    );
  
  }
}
