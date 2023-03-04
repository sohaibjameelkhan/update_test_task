import 'package:dio/dio.dart';

abstract class AuthenticationServices {
  ///posting Signup api request

  Future<Response?> postSignUpRequest(
      String name, String email, String password);

  ///posting login api request

  Future<Response?> postLoginRequest(String email, String password);
}
