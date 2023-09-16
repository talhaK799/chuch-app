import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddGuestBook(),
    );
  }
}

class AddGuestBook extends StatefulWidget {
  const AddGuestBook({Key? key}) : super(key: key);

  @override
  State<AddGuestBook> createState() => _AddGuestBookState();
}

class _AddGuestBookState extends State<AddGuestBook> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController specialRequestsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: navigateToWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Guest',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                CustomTextField(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {},
                ),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email.';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                ),
                CustomTextField(
                  labelText: 'Special Requests',
                  hintText: 'Enter any special requests',
                  maxLines: 3,
                  controller: specialRequestsController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {},
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    primary: redColor, // Red color
                    textStyle: TextStyle(fontSize: 20),
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    this.maxLines,
    this.controller,
    required this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
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
      ),
    );
  }
}
