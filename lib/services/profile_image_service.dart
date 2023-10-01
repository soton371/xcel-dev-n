import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:xcel_medical_center/model/spider/profile_image_model.dart';

Future<ProfileImageModel> profileImageService(String path) async {
  debugPrint("call profileImageService");
  final Uri url = Uri.parse(addProfileImageUrl);
  try {
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      debugPrint(res);
      final profileImageModel = profileImageModelFromJson(res);
      return profileImageModel;
    } else {
      debugPrint("response.statusCode: ${response.statusCode}");
      debugPrint(response.reasonPhrase);
      final profileImageModel = ProfileImageModel(statusCode: response.statusCode,listResponse: []);
      return profileImageModel;
    }
  } catch (e) {
    debugPrint("e: $e");
    final profileImageModel = ProfileImageModel(statusCode: 500,listResponse: []);
      return profileImageModel;
  }
}
