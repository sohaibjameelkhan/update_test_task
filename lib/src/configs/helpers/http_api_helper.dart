import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/local_storage_text_utils.dart';
import '../utils/log_utils.dart';
import 'exceptions_helper.dart';
import 'hive_local_storage.dart';

class HttpApiHelper {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaGFubmVsIjoiZ2V0cGFpZC1hcHAiLCJpYXQiOjE2NzU5NzIxOTAsImV4cCI6MTY3NjA1ODU5MH0.tvLkNqF0UmWSrMqAC00X3Urpn3yFVTqXI-k7oKeTDKc";

  Future<Response?> get(
    String url,
  ) async {
    String userToken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';
    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      dp(msg: "get response", arg: response.body.toString());
      if (response.statusCode == 200) {
        dp(msg: "response", arg: response.body.toString());
        return response;
      }
      return null;
    } on SocketException catch (e) {
      dp(msg: "No Internet Connection", arg: e.toString());
      throw FetchDataException('No Internet connection');
    } catch (e) {
      dp(msg: "catch ", arg: e.toString());
      rethrow;
    }
  }

  Future<Response?> post(
    String url,
    Object? body,
  ) async {
    String userToken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';
    dp(msg: "user token during post request", arg: userToken.toString());
    try {
      final Response response = await http.post(Uri.parse(url),
          headers: {
            "x-api-channel": "getpaid-app",
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));
      dp(msg: "get response", arg: response.body.toString());

      if (response.statusCode == 200) {
        dp(msg: "response", arg: response.body.toString());

        return response;
      }
      return response;
    } on SocketException catch (e) {
      dp(msg: "No Internet Connection", arg: e.toString());
      throw FetchDataException('No Internet connection');
    } catch (e) {
      dp(msg: "catch ", arg: e.toString());
      rethrow;
    }
  }
}
