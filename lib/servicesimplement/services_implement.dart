import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_project/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/configs/utils/routes_utils.dart';
import 'package:test_project/src/modules/authenticationmodule/services/authentication_services.dart';
import 'package:test_project/src/modules/authenticationmodule/services/social_login_services.dart';
import 'package:test_project/src/modules/myProfileModule/services/uploadimageservice.dart';

import '../configs/helpers/hive_local_storage.dart';
import '../configs/helpers/http_api_helper.dart';
import '../configs/utils/api_endpoints.dart';
import '../configs/utils/log_utils.dart';
import '../configs/utils/snackbar_utils.dart';
import '../src/modules/authenticationmodule/screens/sign_in_screen.dart';
import '../src/modules/myProfileModule/models/user_profile_model.dart';
import '../src/modules/myProfileModule/screens/dashboard_screen.dart';
import '../src/modules/myProfileModule/services/profile_services.dart';

class ServicesImplementation
    implements
        AuthenticationServices,
        ProfileServices,
        SocialLoginService,
        UploadImageService {
  //

  ServicesImplementation(this.httpApiHelper);

  HttpApiHelper httpApiHelper;

  @override
  Future<UserProfileModel?> getUserProfileRequest() async {
    //

    Response? response = await httpApiHelper.get(
      ApiEndPoints.userProfileUrl,
    );

    var jsonResponse = response!.data;

    if (response.statusCode == 200) {
    } else {
      showErrorSnackBarMessage(
          content: jsonResponse["status"]
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""));
    }
    return UserProfileModel.fromJson(jsonResponse);
  }

  ///posting Signup api request

  @override
  Future<Response?> postSignUpRequest(
      String name, String email, String password) async {
    final Response? response = await httpApiHelper.post(
        ApiEndPoints.registerUrl,
        {"name": name, "email": email, "password": password});
    var jsonResponse = response!.data;

    dp(msg: "user token", arg: jsonResponse);

    if (response.statusCode == 200 || response.statusCode == 400) {
      dp(msg: "user signup status", arg: jsonResponse["message"]);
      showSucessrSnackBarMessage(content: jsonResponse["message"]);
      GoRouter.of(RoutesUtils.cNavigatorState.currentState!.context)
          .go(SignInScreen.routeName);
      dp(msg: "authentication json response", arg: jsonResponse.toString());
      dp(msg: "response message", arg: jsonResponse["status"].toString());
    } else if (response.statusCode == 400) {
      showErrorSnackBarMessage(content: jsonResponse["message"]);
    } else {
      showErrorSnackBarMessage(content: response.statusMessage.toString());
    }

    return response;
  }

  ///posting login api request

  @override
  Future<Response?> postLoginRequest(String email, String password) async {
    final Response? response = await httpApiHelper
        .post(ApiEndPoints.loginUrl, {"email": email, "password": password});
    var jsonResponse = response!.data;

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

  @override
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //  UserCredential userCredential;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await HiveLocalStorage.write(
          boxName: LocalStorageTextUtils.currentRouteBox,
          key: LocalStorageTextUtils.currentRouteKey,
          value: SignInScreen.routeName);
      await HiveLocalStorage.write(
          boxName: LocalStorageTextUtils.userEmailBox,
          key: LocalStorageTextUtils.userEmailKey,
          value: userCredential.user!.email.toString());

      GoRouter.of(RoutesUtils.cNavigatorState.currentState!.context)
          .go(DashBoardScreen.routeName);
      showSucessrSnackBarMessage(content: "Login Successfully");

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      showErrorSnackBarMessage(content: e.toString());
    }
  }

  @override
  Future<Response> updateProfileWithFile(String url, File file, String name,
      String country, String phoneNumber) async {
    String usertoken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';
    // var prefsvar = await SharedPreferences.getInstance();
    // var usertoken = prefsvar.getString("usertoken");
    Map<String, String> headers = {
      "Authorization": 'Bearer $usertoken',
    };
    Dio dio = Dio();
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "name": name,
      "country": country,
      "phone": phoneNumber,
      "profile_image":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    //  formData.fields.add(value);

    dio.options.headers.addAll(headers);

    var response = await dio.post(url, data: formData);
    dp(msg: "image responose", arg: response.statusCode);
    showSucessrSnackBarMessage(
        backgroundcolor: Colors.green, content: "Profile Updated Successfully");

    return response;
  }

  @override
  Future<Response> updateProfileWithOutFile(
      String url, String name, String country, String phoneNumber) async {
    // var prefsvar = await SharedPreferences.getInstance();
    // var usertoken = prefsvar.getString("usertoken");
    String usertoken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';
    Map<String, String> headers = {
      "Authorization": 'Bearer $usertoken',
    };
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "name": name,
      "country": country,
      "phone": phoneNumber,
    });

    dio.options.headers.addAll(headers);

    var response = await dio.post(url, data: formData);
    dp(msg: "image responose", arg: response.statusCode);
    showSucessrSnackBarMessage(
        backgroundcolor: Colors.green, content: "Profile Updated Successfully");

    return response;
  }
}
