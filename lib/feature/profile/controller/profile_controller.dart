import 'dart:convert';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';
import '../model/profile_data.dart';

class ProfileController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  TextEditingController userName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController language = TextEditingController();
  var gender = "".obs;
  var height = "".obs;
  TextEditingController work = TextEditingController();
  TextEditingController age = TextEditingController();

  Rx<UserData?> userData = Rx<UserData?>(null);

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();

    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.getme, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");
        if (response.isSuccess) {
          debugPrint("===========${response.responseData}");
          final Map<String, dynamic> jsonData =
              response.responseData is Map<String, dynamic>
                  ? response.responseData
                  : jsonDecode(response.responseData);

          userData.value = UserData.fromJson(jsonData);
          debugPrint("====HereData======${userData.value}");
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }

  Future<void> logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await preferencesHelper.init();

    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse(Utils.baseUrl + Utils.logout),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint("Response Status: ${response.statusCode}");
        if (response.statusCode == 200) {
          preferencesHelper.clear();
          await googleSignIn.signOut();
          Get.offAllNamed(AppRoute.loginScreen);
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }

  var avatarFile = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future<void> pickImageFromGallery() async {
    await requestStoragePermission();
    if (await Permission.manageExternalStorage.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarFile.value = File(image.path);
      }
    } else {
      Get.snackbar("Permission Denied", "Storage permission is required.");
    }
  }

  Future<void> pickImageFromCamera() async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        avatarFile.value = File(image.path);
      }
    } else {
      Get.snackbar("Permission Denied", "Camera permission is required.");
    }
  }

  void showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
