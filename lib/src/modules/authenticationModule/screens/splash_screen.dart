import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/src/modules/authenticationModule/screens/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  checkStatus() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      GoRouter.of(context).go(SignUpScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        "assets/images/templogopng.png",
        fit: BoxFit.cover,
        height: 200,
        width: 200,
      ),
    ));
  }
}
