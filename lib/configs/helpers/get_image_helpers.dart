import 'package:image_picker/image_picker.dart';

import '../utils/log_utils.dart';

class PickImageHelper {
  static Future<XFile?> getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();

    try {
      return await picker.pickImage(
        imageQuality: 35,
        source: imageSource,
      );
    } on Exception catch (e) {
      dp(msg: "Error in picking image", arg: e);
      return null;
    }
  }

  static Future<List<XFile>?> getMultipleImages(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();

    try {
      return await picker.pickMultiImage(imageQuality: 40);
    } on Exception catch (e) {
      dp(msg: "Error in picking image", arg: e);
      return null;
    }
  }
}
