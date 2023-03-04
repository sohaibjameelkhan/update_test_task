import 'package:image_picker/image_picker.dart';

import '../utils/log_utils.dart';

// This class provides helper methods for picking images using the ImagePicker package
class PickImageHelper {
  // This method retrieves a single image from the specified source (camera or gallery)
  static Future<XFile?> getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker(); // create an instance of the ImagePicker class

    try {
      return await picker.pickImage( // attempt to pick an image
        imageQuality: 35, // set the quality of the image
        source: imageSource, // set the source of the image
      );
    } on Exception catch (e) { // catch any exceptions that are thrown
      dp(msg: "Error in picking image", arg: e); // call a function to handle the exception
      return null; // return null to indicate that an error occurred
    }
  }

  // This method retrieves multiple images from the specified source (camera or gallery)
  static Future<List<XFile>?> getMultipleImages(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker(); // create an instance of the ImagePicker class

    try {
      return await picker.pickMultiImage(imageQuality: 40); // attempt to pick multiple images
    } on Exception catch (e) { // catch any exceptions that are thrown
      dp(msg: "Error in picking image", arg: e); // call a function to handle the exception
      return null; // return null to indicate that an error occurred
    }
  }
}

