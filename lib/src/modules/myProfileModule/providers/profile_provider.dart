import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/src/configs/helpers/get_image_helpers.dart';
import 'package:test_project/src/configs/utils/app_colors.dart';
import 'package:test_project/src/configs/utils/snackbar_utils.dart';
import 'package:test_project/src/configs/utils/theme.dart';

import '../../../configs/utils/api_endpoints.dart';
import '../models/user_profile_model.dart';
import '../services/profile_services.dart';
import '../services/uploadimageservice.dart';

class ProfileProvider extends ChangeNotifier {
  XFile? imageFile;
  CroppedFile? croppedImage;
  UserProfileModel? userProfileModel;
  bool isLoading = false;
  UploadImageService uploadImageService = UploadImageService();

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  ProfileServices profileServices = ProfileServices();

  getUserProfileProvider() async {
    try {
      await Future.delayed(Duration(milliseconds: 50));
      makeLoadingTrue();
      userProfileModel =
          await profileServices.getUserProfileRequest().whenComplete(() {
        makeLoadingFalse();
      });
      notifyListeners();
      dp(
          msg: "use profile model provider print",
          arg: userProfileModel!.toString());
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: fontW3S12(context)!.copyWith(color: AppColors.whitecolor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(height: 1, color: AppColors.appcolor),
                  ListTile(
                    onTap: () {
                      pickProfileImage(context, ImageSource.gallery);
                      //_openGallery(context);
                    },
                    title: Text(
                      "Gallery",
                      style: fontW3S12(context)!
                          .copyWith(color: AppColors.whitecolor),
                    ),
                    leading: const Icon(
                      Icons.account_box,
                      color: AppColors.whitecolor,
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.appcolor),
                  ListTile(
                    onTap: () {
                      pickProfileImage(context, ImageSource.camera);
                      //  _openCamera(context);
                    },
                    title: Text(
                      "Camera",
                      style: fontW3S12(context)!
                          .copyWith(color: AppColors.whitecolor),
                    ),
                    leading:
                        const Icon(Icons.camera, color: AppColors.whitecolor),
                  ),
                ],
              ),
            ),
          );
        });
  }

  pickProfileImage(context, ImageSource imageSource) async {
    croppedImage = null;
    var xFile = await PickImageHelper.getImage(imageSource);

    if (xFile != null) {
      Navigator.pop(context);
      cropProfilePicFunc(
        image: File(xFile.path),
      );

      dp(msg: "image picked", arg: xFile.path);

      notifyListeners();
    } else {
      showErrorSnackBarMessage(content: "Picture not picked");
    }
  }

  cropProfilePicFunc({
    required File image,
  }) async {
    croppedImage = await ImageCropper.platform.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Image',
            toolbarColor: AppColors.appcolor,
            showCropGrid: true,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ]);
    if (croppedImage != null) {
      // uploadfiledio(firstName, lastName, phoneNumber);
    }
    notifyListeners();
  }

  updateProfileProvider(
      File? file, String name, String country, String phone) async {
    try {
      //  await Future.delayed(Duration(milliseconds: 50));
      makeLoadingTrue();

      uploadImageService
          .updateProfileWithFile(
              ApiEndPoints.updateUserProfileUrl, file!, name, country, phone)
          .whenComplete(() {
        makeLoadingFalse();
        getUserProfileProvider();
      });

      notifyListeners();
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }

  updateWithOutImageProfileProvider(
      String name, String country, String phone) async {
    try {
      //  await Future.delayed(Duration(milliseconds: 50));
      makeLoadingTrue();

      uploadImageService
          .updateProfileWithOutFile(
              ApiEndPoints.updateUserProfileUrl, name, country, phone)
          .whenComplete(() {
        makeLoadingFalse();
        getUserProfileProvider();
      });

      notifyListeners();
    } on Exception catch (e) {
      makeLoadingFalse();
      showErrorSnackBarMessage(content: e.toString());
      // TODO
    }
  }
}
