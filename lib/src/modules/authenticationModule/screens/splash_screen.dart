import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/sign_in_screen.dart';
import 'package:test_project/src/modules/myProfileModule/screens/dashboard_screen.dart';

import '../../../../configs/helpers/hive_local_storage.dart';

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

  checkStatus() async {
    //

    String currentRoute = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.currentRouteBox,
          key: LocalStorageTextUtils.currentRouteKey,
        ) ??
        '';

    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      //

      if (currentRoute == SignInScreen.routeName) {
        GoRouter.of(context).go(DashBoardScreen.routeName);
      } else {
        GoRouter.of(context).go(SignInScreen.routeName);
      }
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
