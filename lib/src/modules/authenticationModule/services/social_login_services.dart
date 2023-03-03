import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../configs/helpers/hive_local_storage.dart';
import '../../../configs/utils/local_storage_text_utils.dart';
import '../../../configs/utils/routes_utils.dart';
import '../../../configs/utils/snackbar_utils.dart';
import '../../myProfileModule/screens/dashboard_screen.dart';
import '../screens/sign_in_screen.dart';

class SocialLoginService {
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

      GoRouter.of(RoutesUtils.cNavigatorState.currentState!.context)
          .go(DashBoardScreen.routeName);
      showSucessrSnackBarMessage(content: "Login Successfully");

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      showErrorSnackBarMessage(content: e.toString());
    }
  }
}
