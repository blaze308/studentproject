import 'dart:io';
import 'dart:math';

import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';

class MyCloudinary {
  final ImagePicker imagePicker = ImagePicker();
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "569185919255626",
    apiSecret: "5ZKBMSey-e5mvx0bsQWDy_WztV0",
    cloudName: "dn1lv5x6e",
  );

  static CloudinaryResponse? response;
  uploadImage() async {
    var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var imagePath = pickedFile.path;
      File imageFile = File(imagePath);

      response = await cloudinary.upload(
        file: imageFile.path,
        fileBytes: imageFile.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: "products",
        // fileName: imageFile.toString(),
      );
      if (response!.isSuccessful) {
        print(response);
        // return response!.secureUrl;
      }
    } else {
      print("select image");
    }
  }
}
