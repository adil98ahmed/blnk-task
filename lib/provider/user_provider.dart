import 'dart:io';
import 'package:blnk_task/apis/googleSheetsAPI.dart';
import 'package:blnk_task/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool wait = false;
  final ImagePicker _picker = ImagePicker();
  UserModel user = UserModel();
  uploadImage() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('users/' +
              user.firstName +
              ' ' +
              user.lastName +
              '' +
              user.mobile +
              '/' +
              'front')
          .putFile(user.frontIdImage);
      await firebase_storage.FirebaseStorage.instance
          .ref('users/' +
              user.firstName +
              ' ' +
              user.lastName +
              '' +
              user.mobile +
              '/' +
              'back')
          .putFile(user.backIdImage);
    } on FirebaseException catch (e) {
      print(e);
      print(e);
    }
  }

  takePhoto(String frontOrBack) async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (frontOrBack == "front") {
      user.frontIdImage = File(image.path);
    } else {
      user.backIdImage = File(image.path);
    }
    notifyListeners();
  }

  readTextFromImage() async {
    FirebaseVisionImage myImage =
        FirebaseVisionImage.fromFile(user.frontIdImage);

    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);
    for (TextBlock block in readText.blocks)
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          if (word.text.length == 14) {
            var tryToParse = double.tryParse(word.text);
            if (tryToParse != null) {
              user.id = word.text;
            }
          }
        }
      }
    if (user.id == null) {
      user.id = "-1";
    }
    notifyListeners();
  }

  Future<bool> register() async {
    if (user.id != null &&
        user.firstName != null &&
        user.lastName != null &&
        user.address != null &&
        user.mobile != null &&
        user.frontIdImage != null &&
        user.backIdImage != null) {
      if (UsersSheetApi.userSheet == null) {
      } else {
        wait = true;
        notifyListeners();

        await UsersSheetApi.userSheet.values.map.appendRows([
          {
            "Id": user.id,
            "First Name": user.firstName,
            "Last Name": user.lastName,
            "Address": user.lastName,
            "Mobile": user.mobile
          }
        ]);
        wait = false;
        notifyListeners();
        return true;
      }
    } else {
      return false;
    }
  }
}
