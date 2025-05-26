import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paramount_student/core/services/Network_services/app_apis.dart';
import 'package:permission_handler/permission_handler.dart';

import '../dialogs/helper_dialogs.dart';
import '../exceptions/net_work_excptions.dart';




class HelperFunctions {

  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage({ImageSource source = ImageSource.gallery, required BuildContext context}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;
      File imageFile = File(image.path);
      return await _compressImage(imageFile);
    } catch (e) {
      ExceptionHandler.handle(e, context);
      return null;
    }
  }

  static Future<bool> requestPermission({required Permission permission, required BuildContext context,}) async {
    try {
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        return true; // ✅ Permission granted
      } else if (status.isDenied) {
        debugPrint("⚠️ Permission denied. Retrying...");
        return await _retryPermission(permission, context);
      } else if (status.isPermanentlyDenied) {
        debugPrint("⚠️ Permission permanently denied. Showing settings dialog...");
        DialogHelper.showSettingsDialog(context);
        return false;
      }
      return false;
    } catch (e) {
      ExceptionHandler.handle(e, context);
      return false;
    }
  }

  static Future<bool> _retryPermission(Permission permission, BuildContext context) async {
    for (int i = 0; i < 2; i++) {
      final status = await permission.request();
      if (status.isGranted) return true;
      if (status.isPermanentlyDenied) {
        DialogHelper.showSettingsDialog(context);
        return false;
      }
    }
    return false;
  }


  static Future<File> _compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 800,
      minHeight: 800,
      quality: 25,
      format: CompressFormat.jpeg,
    );
    return File(file.absolute.path)..writeAsBytesSync(result!);
  }

  static String convertMonthsToYears(int months, {int decimalPlaces = 1}) {
    if (months <= 0) return '0';
    double years = months / 12;
    return years.toStringAsFixed(decimalPlaces);
  }

  static String getFullProfilePictureUrl({required int userId,required String imageUrl}) {
    if (imageUrl.startsWith('http')) {
      return imageUrl;
    }
    const String baseUrl = '${AppApis.domainUrl}/user_img';
    return '$baseUrl/$userId/$imageUrl';
  }

}