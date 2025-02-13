// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

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
import '../../meet_people/controller/filter_controller.dart';
import '../model/profile_data.dart';

class ProfileController extends GetxController {
  final filterController = Get.put(FilterController());
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  TextEditingController userName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController genderText = TextEditingController();
  TextEditingController heightText = TextEditingController();
  TextEditingController statusText = TextEditingController();
  var gender = "".obs;
  var height = "".obs;
  var status = "".obs;
  TextEditingController work = TextEditingController();
  TextEditingController age = TextEditingController();
  var isLoading = false.obs;
  var avatarFile = Rx<File?>(null);
  var selectedImages = <File>[].obs;
 
  Map<String, dynamic> upadateNewData = {};

  updatestaus(String selectedStatus) {
    status.value = selectedStatus;
    statusText.text = status.value;
  }

  Map<String, dynamic> saveUserInformation() {
    String? country = filterController.selectedCountry.value;
    String? fullname = fullName.text;
    String? updateUserNmae = userName.text;
    String? updategender = gender.value;
    String? updateHeight = height.value;
    String? updateAge = age.text;
    String? updateWork = work.text;
    String? updateLanguage = language.text;
    String? updateStatus = status.value;

    Map<String, dynamic> userInformation = {
      "fullName": fullname,
      "country": country,
      "gender": updategender,
      "height": updateHeight,
      "age": updateAge,
      "work": updateWork,
      "language": updateLanguage,
      "username": updateUserNmae,
      "relationship": updateStatus
    };
    upadateNewData = userInformation;
    debugPrint("====bodyData======$upadateNewData");
    return userInformation;
  }

  void updateGender(String selectedGender) {
    gender.value = selectedGender;
    genderText.text = gender.value;
  }

  void updateHeight(String selectedHeight) {
    height.value = selectedHeight;
    heightText.text = height.value;
  }

  Rx<UserData?> userData = Rx<UserData?>(null);

  Future<void> submitUserData({File? profileImage}) async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    if (token != null) {
      try {
        isLoading.value = true;
        final url = Uri.parse('${Utils.baseUrl}${Utils.profile}');
        debugPrint("============$url");
        var request = http.MultipartRequest('PUT', url);
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        request.fields['bodyData'] = jsonEncode(upadateNewData);
        if (profileImage != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'profileImage',
            profileImage.path,
          ));
        }

        var streamedResponse = await request.send();

        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          debugPrint('====Success: ${response.body}');
          debugPrint('====Success: ${avatarFile.value}');
          Get.offNamed(AppRoute.profile);
        } else {
          debugPrint('====Error: ${response.statusCode}, ${response.body}');
        }
      } catch (e) {
        isLoading.value = false;
        debugPrint('====An error occurred: $e');
      } finally {
        isLoading.value = false;
        await getUserProfiles();
      }
    }
  }

  Future<void> uploadMultipleImages() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      try {
        isLoading.value = true;
        final url = Uri.parse('${Utils.baseUrl}${Utils.uploadGallery}');
        debugPrint("API URL: $url");

        var request = http.MultipartRequest('PUT', url);
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        for (var image in selectedImages) {
          request.files.add(await http.MultipartFile.fromPath(
            'gallery',
            image.path,
          ));
        }
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          debugPrint('Success: ${response.body}');
          Get.snackbar("Upload Success", "Images uploaded successfully.");
        } else {
          debugPrint('Error: ${response.statusCode}, ${response.body}');
          Get.snackbar(
            "Upload Failed",
            "Failed to upload images. Error: ${response.body}",
          );
        }
      } catch (e) {
        debugPrint('An error occurred: $e');
        Get.snackbar("Upload Error", "An error occurred: $e");
      } finally {
        isLoading.value = false;
        await getUserProfiles();
      }
    } else {
      debugPrint("Token is null. Please log in again.");
      Get.snackbar("Authentication Error", "Please log in to upload images.");
    }
  }

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();

    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      isLoading.value = true;
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
          isLoading.value = false;
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        isLoading.value = false;
        debugPrint("Error occurred: $e");
      }finally{
        isLoading.value = false;
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

  final ImagePicker _picker = ImagePicker();

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<bool> requestGalleryPermission() async {
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<void> pickImageFromGallery(bool isProfile) async {
    requestGalleryPermission();
    if (await Permission.photos.isGranted) {
      if (isProfile) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          avatarFile.value = File(image.path);
        }
      } else {
        if (selectedImages.length >= 5) {
          Get.snackbar("Limit Reached", "You can select up to 5 images only.");
          return;
        }

        final List<XFile>? images = await _picker.pickMultiImage();
        if (images != null && images.isNotEmpty) {
          if (selectedImages.length + images.length > 5) {
            Get.snackbar(
              "Limit Reached",
              "You can only select up to 5 images in total.",
            );
            return;
          }
          selectedImages
              .addAll(images.map((image) => File(image.path)).toList());
          await uploadMultipleImages();
        }
      }
    } else {
      Get.snackbar("Permission Denied", "Storage permission is required.");
    }
  }

  Future<void> pickImageFromCamera(bool isProfile) async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        if (isProfile) {
          avatarFile.value = File(image.path);
        } else {
          selectedImages.add(File(image.path));
        }
      }
    } else {
      Get.snackbar("Permission Denied", "Camera permission is required.");
    }
  }

  updateData() {
    userName.text = userData.value?.username.toString() ?? "Unknown";
    fullName.text = userData.value?.fullName.toString() ?? "Unknown";
    language.text = userData.value?.language.toString() ?? "Unknown";
    height.value = userData.value?.height.toString() ?? "Unknown";
    age.text = userData.value?.age.toString() ?? "Unknown";
    gender.value = userData.value?.gender.toString() ?? "Unknown";
    work.text = userData.value?.work.toString() ?? "Unknown";
    statusText.text = userData.value?.relationship.toString() ?? "Unknown";
    filterController.selectedCountry.value =
        userData.value?.country.toString() ?? "Unknown";
  }

  void showImagePickerDialog(BuildContext context, bool isProfile) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  pickImageFromCamera(isProfile);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  pickImageFromGallery(isProfile);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String countryToEmoji2(String countryName) {
    const countryCodes = {
      'Afghanistan': 'AF',
      'Albania': 'AL',
      'Algeria': 'DZ',
      'Andorra': 'AD',
      'Angola': 'AO',
      'Argentina': 'AR',
      'Armenia': 'AM',
      'Australia': 'AU',
      'Austria': 'AT',
      'Azerbaijan': 'AZ',
      'Bahamas': 'BS',
      'Bahrain': 'BH',
      'Bangladesh': 'BD',
      'Barbados': 'BB',
      'Belarus': 'BY',
      'Belgium': 'BE',
      'Belize': 'BZ',
      'Benin': 'BJ',
      'Bhutan': 'BT',
      'Bolivia': 'BO',
      'Bosnia and Herzegovina': 'BA',
      'Botswana': 'BW',
      'Brazil': 'BR',
      'Brunei': 'BN',
      'Bulgaria': 'BG',
      'Burkina Faso': 'BF',
      'Burundi': 'BI',
      'Cambodia': 'KH',
      'Cameroon': 'CM',
      'Canada': 'CA',
      'Cape Verde': 'CV',
      'Central African Republic': 'CF',
      'Chad': 'TD',
      'Chile': 'CL',
      'China': 'CN',
      'Colombia': 'CO',
      'Comoros': 'KM',
      'Congo (Congo-Brazzaville)': 'CG',
      'Congo (Democratic Republic)': 'CD',
      'Costa Rica': 'CR',
      'Croatia': 'HR',
      'Cuba': 'CU',
      'Cyprus': 'CY',
      'Czech Republic': 'CZ',
      'Denmark': 'DK',
      'Djibouti': 'DJ',
      'Dominica': 'DM',
      'Dominican Republic': 'DO',
      'Ecuador': 'EC',
      'Egypt': 'EG',
      'El Salvador': 'SV',
      'Equatorial Guinea': 'GQ',
      'Eritrea': 'ER',
      'Estonia': 'EE',
      'Eswatini': 'SZ',
      'Ethiopia': 'ET',
      'Fiji': 'FJ',
      'Finland': 'FI',
      'France': 'FR',
      'Gabon': 'GA',
      'Gambia': 'GM',
      'Georgia': 'GE',
      'Germany': 'DE',
      'Ghana': 'GH',
      'Greece': 'GR',
      'Grenada': 'GD',
      'Guatemala': 'GT',
      'Guinea': 'GN',
      'Guinea-Bissau': 'GW',
      'Guyana': 'GY',
      'Haiti': 'HT',
      'Honduras': 'HN',
      'Hungary': 'HU',
      'Iceland': 'IS',
      'India': 'IN',
      'Indonesia': 'ID',
      'Iran': 'IR',
      'Iraq': 'IQ',
      'Ireland': 'IE',
      'Israel': 'IL',
      'Italy': 'IT',
      'Jamaica': 'JM',
      'Japan': 'JP',
      'Jordan': 'JO',
      'Kazakhstan': 'KZ',
      'Kenya': 'KE',
      'Kiribati': 'KI',
      'Korea (North)': 'KP',
      'Korea (South)': 'KR',
      'Kuwait': 'KW',
      'Kyrgyzstan': 'KG',
      'Laos': 'LA',
      'Latvia': 'LV',
      'Lebanon': 'LB',
      'Lesotho': 'LS',
      'Liberia': 'LR',
      'Libya': 'LY',
      'Liechtenstein': 'LI',
      'Lithuania': 'LT',
      'Luxembourg': 'LU',
      'Madagascar': 'MG',
      'Malawi': 'MW',
      'Malaysia': 'MY',
      'Maldives': 'MV',
      'Mali': 'ML',
      'Malta': 'MT',
      'Marshall Islands': 'MH',
      'Mauritania': 'MR',
      'Mauritius': 'MU',
      'Mexico': 'MX',
      'Micronesia': 'FM',
      'Moldova': 'MD',
      'Monaco': 'MC',
      'Mongolia': 'MN',
      'Montenegro': 'ME',
      'Morocco': 'MA',
      'Mozambique': 'MZ',
      'Myanmar': 'MM',
      'Namibia': 'NA',
      'Nauru': 'NR',
      'Nepal': 'NP',
      'Netherlands': 'NL',
      'New Zealand': 'NZ',
      'Nicaragua': 'NI',
      'Niger': 'NE',
      'Nigeria': 'NG',
      'North Macedonia': 'MK',
      'Norway': 'NO',
      'Oman': 'OM',
      'Pakistan': 'PK',
      'Palau': 'PW',
      'Palestine': 'PS',
      'Panama': 'PA',
      'Papua New Guinea': 'PG',
      'Paraguay': 'PY',
      'Peru': 'PE',
      'Philippines': 'PH',
      'Poland': 'PL',
      'Portugal': 'PT',
      'Qatar': 'QA',
      'Romania': 'RO',
      'Russia': 'RU',
      'Rwanda': 'RW',
      'Saint Kitts and Nevis': 'KN',
      'Saint Lucia': 'LC',
      'Saint Vincent and the Grenadines': 'VC',
      'Samoa': 'WS',
      'San Marino': 'SM',
      'Sao Tome and Principe': 'ST',
      'Saudi Arabia': 'SA',
      'Senegal': 'SN',
      'Serbia': 'RS',
      'Seychelles': 'SC',
      'Sierra Leone': 'SL',
      'Singapore': 'SG',
      'Slovakia': 'SK',
      'Slovenia': 'SI',
      'Solomon Islands': 'SB',
      'Somalia': 'SO',
      'South Africa': 'ZA',
      'South Sudan': 'SS',
      'Spain': 'ES',
      'Sri Lanka': 'LK',
      'Sudan': 'SD',
      'Suriname': 'SR',
      'Sweden': 'SE',
      'Switzerland': 'CH',
      'Syria': 'SY',
      'Tajikistan': 'TJ',
      'Tanzania': 'TZ',
      'Thailand': 'TH',
      'Timor-Leste': 'TL',
      'Togo': 'TG',
      'Tonga': 'TO',
      'Trinidad and Tobago': 'TT',
      'Tunisia': 'TN',
      'Turkey': 'TR',
      'Turkmenistan': 'TM',
      'Tuvalu': 'TV',
      'Uganda': 'UG',
      'Ukraine': 'UA',
      'United Arab Emirates': 'AE',
      'United Kingdom': 'GB',
      'United States': 'US',
      'Uruguay': 'UY',
      'Uzbekistan': 'UZ',
      'Vanuatu': 'VU',
      'Vatican City': 'VA',
      'Venezuela': 'VE',
      'Vietnam': 'VN',
      'Yemen': 'YE',
      'Zambia': 'ZM',
      'Zimbabwe': 'ZW',
    };

    String? countryCode = countryCodes[countryName];

    if (countryCode == null) {
      return '🏳️';
    }

    String emoji = countryCode
        .toUpperCase()
        .codeUnits
        .map((code) => String.fromCharCode(0x1F1E6 + code - 65))
        .join();

    return emoji;
  }
}
