import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_project/src/configs/utils/api_endpoints.dart';
import 'package:test_project/src/configs/utils/snackbar_utils.dart';

import '../../../configs/helpers/http_api_helper.dart';
import '../models/user_profile_model.dart';

class ProfileServices {
  HttpApiHelper httpApiHelper = HttpApiHelper();

  Future<UserProfileModel?> getUserProfileRequest() async {
    Response? response = await httpApiHelper.get(
      ApiEndPoints.userProfileUrl,
    );
    var jsonResponse = jsonDecode(response!.body);
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
}
