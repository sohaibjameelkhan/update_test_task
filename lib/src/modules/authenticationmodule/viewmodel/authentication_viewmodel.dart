import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:test_project/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/configs/utils/snackbar_utils.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/sign_in_screen.dart';

import '../../../../configs/helpers/hive_local_storage.dart';
import '../../../../configs/utils/log_utils.dart';
import '../services/authentication_services.dart';
import '../services/social_login_services.dart';

class AuthenticationViewModel extends ChangeNotifier {
  AuthenticationServices _authServices;

  SocialLoginService _socialLoginService;

  AuthenticationViewModel(AuthenticationServices _authServices,
      SocialLoginService socialLoginService)
      : this._authServices = _authServices,
        this._socialLoginService = socialLoginService;

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

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

  sendSignUpApiRequestProvider(
      String name, String email, String password) async {
    try {
      makeLoadingTrue();
      await _authServices
          .postSignUpRequest(name, email, password)
          .whenComplete(() {
        makeLoadingFalse();
      });

      notifyListeners();

      dp(
        msg: "register api model provider print",
      );
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }

  sendLoginApiRequestProvider(String email, String password) async {
    try {
      makeLoadingTrue();
      _authServices.postLoginRequest(email, password).whenComplete(() {
        makeLoadingFalse();
      });

      notifyListeners();
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }

  loginWithGoogle() async {
    try {
      makeLoadingTrue();
      _socialLoginService.signInWithGoogle().whenComplete(() {
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
    await HiveLocalStorage.deleteHiveValue(
        boxName: LocalStorageTextUtils.userEmailBox,
        key: LocalStorageTextUtils.userEmailKey);
    await HiveLocalStorage.deleteHiveValue(
        boxName: LocalStorageTextUtils.userTokenBox,
        key: LocalStorageTextUtils.userTokenKey);
    //await _authServices.logoutUser();
    GoogleSignIn().signOut();
    // FacebookAuth.instance.logOut();
    GoRouter.of(context).go(SignInScreen.routeName);

    // toRemoveAll(context: context, widget: LoginScreen());
    //pushNewScreen(context, withNavBar: false, screen: SignInScreen());
    await showSucessrSnackBarMessage(content: "Logout Successfully");
  }
}
