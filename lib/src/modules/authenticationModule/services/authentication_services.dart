import 'package:dio/dio.dart';

import '../../../../configs/helpers/http_api_helper.dart';

abstract class AuthenticationServices {
  ///posting Signup api request

  Future<Response?> postSignUpRequest(
      String name, String email, String password);

  ///posting login api request

  Future<Response?> postLoginRequest(String email, String password);
}
