import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:test_project/src/configs/utils/api_endpoints.dart';
import 'package:test_project/src/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/src/configs/utils/routes_utils.dart';
import 'package:test_project/src/configs/utils/snackbar_utils.dart';
import 'package:test_project/src/modules/authenticationModule/screens/sign_in_screen.dart';
import 'package:test_project/src/modules/myProfileModule/screens/dashboard_screen.dart';

import '../../../configs/helpers/hive_local_storage.dart';
import '../../../configs/helpers/http_api_helper.dart';

class AuthenticationServices {
  HttpApiHelper httpApiHelper = HttpApiHelper();

  ///posting Signup api request

  Future<Response?> postSignUpRequest(
      String name, String email, String password) async {
    final Response? response = await httpApiHelper.post(
        ApiEndPoints.registerUrl,
        {"name": name, "email": email, "password": password});
    var jsonResponse = jsonDecode(response!.body);

    dp(msg: "user token", arg: jsonResponse);

    if (response.statusCode == 200) {
      dp(msg: "user signup status", arg: jsonResponse["message"]);

      showSucessrSnackBarMessage(content: jsonResponse["message"]);
      GoRouter.of(RoutesUtils.cNavigatorState.currentState!.context)
          .go(SignInScreen.routeName);
    } else {
      showErrorSnackBarMessage(content: jsonResponse["message"]);

      dp(msg: "authentication json response", arg: jsonResponse.toString());
      dp(msg: "response message", arg: jsonResponse["status"].toString());
    }

    return response;
  }

  ///posting login api request

  Future<Response?> postLoginRequest(String email, String password) async {
    final Response? response = await httpApiHelper
        .post(ApiEndPoints.loginUrl, {"email": email, "password": password});
    var jsonResponse = jsonDecode(response!.body);

    dp(msg: "user response", arg: jsonResponse);

    if (response.statusCode == 201) {
      await HiveLocalStorage.write(
          boxName: LocalStorageTextUtils.currentRouteBox,
          key: LocalStorageTextUtils.currentRouteKey,
          value: SignInScreen.routeName);

      await HiveLocalStorage.write(
          boxName: LocalStorageTextUtils.userEmailBox,
          key: LocalStorageTextUtils.userEmailKey,
          value: jsonResponse["user"]["email"]);

      await HiveLocalStorage.write(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
          value: jsonResponse["token"].toString());
      GoRouter.of(RoutesUtils.cNavigatorState.currentState!.context)
          .go(DashBoardScreen.routeName);

      showSucessrSnackBarMessage(content: "Login Successfully");

      String userToken = await HiveLocalStorage.readHiveValue(
        boxName: LocalStorageTextUtils.userTokenBox,
        key: LocalStorageTextUtils.userTokenKey,
      );
      dp(msg: "hive user token", arg: userToken.toString());
      dp(msg: "authentication json response", arg: jsonResponse.toString());
      dp(msg: "response message", arg: jsonResponse["status"].toString());
    } else {
      showErrorSnackBarMessage(
          content: jsonResponse["message"].toString().replaceAll("[", ""));
    }

    return jsonResponse;
  }
}
