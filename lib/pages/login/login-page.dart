import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/login/login-controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widgets/circular_progress_indicator_widget.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<LoginController>(builder: (controller) {
          return SingleChildScrollView(
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
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  !controller.forgotPassword
                      ? TextFormField(
                          controller: controller.password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(controller.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: controller.toggleVisibilityofPassword,
                            ),
                          ),
                          obscureText: !controller.showPassword,
                        )
                      : Container(),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: controller.toggleForgotPassword,
                    child: Text(
                      controller.forgotPassword ? 'Cancel' : 'Forgot Password?',
                      style: TextStyle(
                        color: redColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return Container(
                      child: controller.isLoading.value
                          ? CircularProgressIndicatorWidget()
                          : buildCTABtn(
                              redColor,
                              controller.forgotPassword
                                  ? 'Send Reset Link'
                                  : 'Sign In',
                              () => controller.forgotPassword
                                  ? controller.onResetPassword()
                                  : controller.onSignIn(),
                            ),
                    );
                  }),
                  SizedBox(height: 30),
                  Center(child: Text('or')),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: controller.navigateToRegister,
                    child: Center(
                      child: Text(
                        "Don't have an account? Sign Up",
                      ),
                    ),
                  ),
                  30.height,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.apiCall();
                      },
                      child: Text(
                        'click',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        }));
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
