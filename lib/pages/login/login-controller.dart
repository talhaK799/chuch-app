import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/authentication.dart';
import 'package:churchappenings/services/hasura.dart';
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
  RxBool isLoading = false.obs;
  final api = ProfileAPI();

  Future apiCall() async {
    final HasuraService hasura = HasuraService.to;
    await hasura.unAuthenticationConnection();
    await api.callQuery();
  }

  onSignIn() async {
    isLoading.value = true;

    var result = await auth.signIn(
      email: email.value.text,
      password: password.value.text,
    );
    await Future.delayed(Duration(milliseconds: 500));

    isLoading.value = false;

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
