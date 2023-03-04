import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_project/configs/utils/snackbar_utils.dart';

import '../utils/local_storage_text_utils.dart';
import '../utils/log_utils.dart';
import 'exceptions_helper.dart';
import 'hive_local_storage.dart';

class HttpApiHelper {
  Dio dio;

  HttpApiHelper(this.dio);

  Future<Response?> get(String url) async {
    //

    String userToken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';

    try {
      final Response response = await dio.get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $userToken',
        }),
      );

      dp(msg: "get response", arg: response.data.toString());

      if (response.statusCode == 200) {
        dp(msg: "response", arg: response.data.toString());
        return response;
      }

      return null;
    } on SocketException catch (e) {
      dp(msg: "No Internet Connection", arg: e.toString());
      showErrorSnackBarMessage(content: "No Internet Connection");
      throw FetchDataException('No Internet connection');
    } catch (e) {
      dp(msg: "catch ", arg: e.toString());
      rethrow;
    }
  }

  //// This method makes an asynchronous POST request and returns a Response type object if successful

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
    // Attempt to make an asynchronous POST request
    try {
      final Response response = await dio.post(url,
          options: Options(headers: {
            //   "x-api-channel": "getpaid-app",
            "Content-Type": "application/json",
            'Authorization': 'Bearer $userToken',
          }),
          data: jsonEncode(body));

      // Log the response

      dp(msg: "get response", arg: response.data.toString());
// Return the response
      return response;
    } on DioError catch (e) {
      return showErrorSnackBarMessage(
          content: e.response!.data["message"].toString());
      // Handle SocketException (no internet connection)
    } on SocketException catch (e) {
      showErrorSnackBarMessage(content: "No Internet Connection");
      dp(msg: "No Internet Connection", arg: e.toString());
      throw FetchDataException('No Internet connection');
    } catch (e) {
      dp(msg: "catch ", arg: e.toString());
      rethrow;
    }
  }
}
