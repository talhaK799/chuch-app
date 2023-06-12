import 'package:churchappenings/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class RegisterController extends GetxController {
  final Authentication auth = Authentication.to;
  bool _showPassword = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  TextEditingController get name => _name;
  TextEditingController get email => _email;
  TextEditingController get password => _password;
  bool get showPassword => _showPassword;

  onSignUp() async {
    print(await auth.signUp(
      name: name.value.text,
      email: email.value.text,
      password: password.value.text,
    ));
  }

  toggleVisibilityofPassword() {
    _showPassword ? _showPassword = false : _showPassword = true;
    update();
  }

  navigateToLogin() {
    Get.toNamed(Routes.login);
  }
}
