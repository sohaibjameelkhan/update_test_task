import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_project/src/configs/utils/snackbar_utils.dart';

import '../../../configs/helpers/hive_local_storage.dart';
import '../../../configs/utils/local_storage_text_utils.dart';

class UploadImageService {
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
    Dio dio = new Dio();
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
    Dio dio = new Dio();

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
