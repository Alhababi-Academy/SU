import 'dart:async';
import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';
import 'package:su_project/home/Authentication/login.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  // when page open, this is the frist thing to do
  void initState() {
    // custom Function
    timeFunctoni();
    super.initState();
  }

  timeFunctoni() {
    // this will take 4 seconds
    Timer(const Duration(seconds: 4), () async {
      // go to another page
      Route route = MaterialPageRoute(builder: (_) => const loginPage());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // first widget, white screen
    return Material(
      color: Colors.white,
      // so the widgets does not go up
      child: SafeArea(
        // to put multable widgets
        child: Column(
          // center the column
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // put image
            Image.asset("images/logo.jpg"),
            // text widget
            const SizedBox(
              height: 20,
            ),
            // loading dialog
            const CircularProgressIndicator(
              color: SU.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
