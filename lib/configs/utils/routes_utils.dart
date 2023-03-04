import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/sign_in_screen.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/signup_screen.dart';
import 'package:test_project/src/modules/myProfileModule/screens/dashboard_screen.dart';

import '../../src/modules/authenticationmodule/screens/splash_screen.dart';
import '../../src/modules/myProfileModule/screens/managing_profile.dart';

class RoutesUtils {
  //

  static var cNavigatorState = GlobalKey<NavigatorState>();

  static BuildContext context = cNavigatorState.currentState!.context;
}

Future<T?> toNext<T>({required Widget widget}) => Navigator.push<T?>(
      RoutesUtils.context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => widget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

toRemoveAll({required Widget widget}) => Navigator.pushAndRemoveUntil(
    RoutesUtils.context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => widget,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    (c) => false);

var routerConfigs = GoRouter(
  initialLocation: SplashScreen.routeName,
  navigatorKey: RoutesUtils.cNavigatorState,
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: SplashScreen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SplashScreen());
      },
    ),
    GoRoute(
      path: SignUpScreen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SignUpScreen());
      },
    ),
    GoRoute(
      path: SignInScreen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: SignInScreen());
      },
    ),
    GoRoute(
      path: DashBoardScreen.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: DashBoardScreen());
      },
    ),
    GoRoute(
      path: ManageProfile.routeName,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: ManageProfile());
      },
    ),
    // HomeAddressScreen/
  ],
);
