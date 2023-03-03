import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:test_project/src/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/src/configs/utils/snackbar_utils.dart';
import 'package:test_project/src/modules/authenticationModule/screens/sign_in_screen.dart';
import 'package:test_project/src/modules/authenticationModule/services/authentication_services.dart';
import 'package:test_project/src/modules/authenticationModule/services/social_login_services.dart';

import '../../../configs/helpers/hive_local_storage.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  SocialLoginService socialLoginService = SocialLoginService();

  bool showconfirmobsecure = true;
  bool showpasswordobsecure = true;

  visiblePasswordChange() {
    if (showpasswordobsecure == true) {
      showpasswordobsecure = false;
    } else {
      showpasswordobsecure = true;
    }

    notifyListeners();
  }

  visibleConfirmPasswordChange() {
    if (showconfirmobsecure == true) {
      showconfirmobsecure = false;
    } else {
      showconfirmobsecure = true;
    }

    notifyListeners();
  }

  AuthenticationServices authServices = AuthenticationServices();

  sendSignUpApiRequest(String name, String email, String password) async {
    try {
      makeLoadingTrue();
      Response? response = await authServices
          .postSignUpRequest(name, email, password)
          .whenComplete(() {
        makeLoadingFalse();
      });

      notifyListeners();

      dp(msg: "register api model provider print", arg: response!.toString());
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }

  loginWithGoogle() async {
    try {
      makeLoadingTrue();
      socialLoginService.signInWithGoogle().whenComplete(() {
        makeLoadingFalse();
      });
      // userCredential.user.
    } on FirebaseAuthException catch (e) {
      showErrorSnackBarMessage(content: e.toString());
    } on Exception catch (e) {
      showErrorSnackBarMessage(content: e.toString());
    }
    notifyListeners();
  }

  /// logout user from app and delete local hive values
  logoutFromApp(context) async {
    await HiveLocalStorage.deleteHiveValue(
        boxName: LocalStorageTextUtils.currentRouteBox,
        key: LocalStorageTextUtils.currentRouteKey);
    //await authServices.logoutUser();
    GoogleSignIn().signOut();
    // FacebookAuth.instance.logOut();
    GoRouter.of(context).go(SignInScreen.routeName);

    // toRemoveAll(context: context, widget: LoginScreen());
    //pushNewScreen(context, withNavBar: false, screen: SignInScreen());
    await showSucessrSnackBarMessage(content: "Logout Successfully");
  }
}
