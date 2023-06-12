import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';

import 'register-controller.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navigateToWidget(),
              SizedBox(height: 20),
              Image.asset(
                'assets/logo.png',
                width: 200,
              ),
              SizedBox(height: 50),
              Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: registerController.name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    Icons.account_circle,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: registerController.email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<RegisterController>(builder: (controller) {
                return TextFormField(
                  controller: registerController.password,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.toggleVisibilityofPassword();
                        },
                      )),
                  obscureText: !controller.showPassword,
                );
              }),
              SizedBox(
                height: 20,
              ),
              buildCTABtn(
                redColor,
                'Sign Up',
                () => registerController.onSignUp(),
              ),
              SizedBox(
                height: 30,
              ),
              Center(child: Text('or')),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  registerController.navigateToLogin();
                },
                child: Center(
                  child: Text(
                    "Already have an account? Sign In",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCTABtn(Color color, String text, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          FaIcon(
            FontAwesomeIcons.arrowRight,
            color: Colors.white,
            size: 10,
          ),
        ],
      ),
    ),
  );
}
