import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Authentication auth = Authentication.to;
  bool _showPassword = false;
  bool forgotPassword = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  bool get showPassword => _showPassword;

  onSignIn() async {
    var result = await auth.signIn(
      email: email.value.text,
      password: password.value.text,
    );

    print("SignIN Result => $result");
  }

  onResetPassword() async {
    print(await auth.resetPassword(
      email: email.value.text,
    ));

    forgotPassword = false;
    update();
  }

  toggleForgotPassword() {
    forgotPassword = !forgotPassword;
    update();
  }

  toggleVisibilityofPassword() {
    _showPassword ? _showPassword = false : _showPassword = true;
    update();
  }

  navigateToRegister() {
    Get.toNamed(Routes.register);
  }
}
