import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_project/configs/helpers/hive_local_storage.dart';
import 'package:test_project/configs/utils/local_storage_text_utils.dart';
import 'package:test_project/configs/utils/routes_utils.dart';
import 'package:test_project/configs/utils/snackbar_utils.dart';
import 'package:test_project/src/modules/myProfileModule/screens/dashboard_screen.dart';

import '../screens/sign_in_screen.dart';

abstract class SocialLoginService {
  Future<UserCredential?> signInWithGoogle();
}
