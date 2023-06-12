import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/authentication.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  void navigateToHome() {
    Get.toNamed(Routes.login);
  }

  final Authentication auth = Authentication.to;

  void signInWithGoogle() async {
    await auth.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/logo2.png',
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 200,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Welcome to\nChurchappenings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Managing your church just got easy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w200,
                          height: 1.7,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildCTABtn(Colors.black, FontAwesomeIcons.solidEnvelope,
                        'Continue using Email', navigateToHome),
                    SizedBox(
                      height: 15,
                    ),
                    buildCTABtn(
                      redColor,
                      FontAwesomeIcons.google,
                      'Continue using Google',
                      () => signInWithGoogle(),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildCTABtn(Color color, IconData icon, String text, Function onTap) {
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
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.white),
          )
        ],
      ),
    ),
  );
}
