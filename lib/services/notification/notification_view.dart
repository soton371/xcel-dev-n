import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

Future<bool> messageReadUrl(String msgId) async {
  debugPrint("call messageReadUrl");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String patientId = prefs.getInt(prefUserId).toString();
  Uri url = Uri.parse(notificationReadUrl);
  Map body = {
    "P_MESSAGEID": msgId,
    "P_READEDFLG": "1",
    "P_PERFORMBY": patientId
};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      debugPrint(
          "messageViewUrl response.statusCode: ${response.statusCode}");
      return false;
    }
    debugPrint("messageViewUrl response.body: ${response.body}");
    return true;
  } catch (e) {
    debugPrint("messageViewUrl e: $e");
    return false;
  }
}


Future<bool> notificationView() async {
  debugPrint("call notificationView");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String patientId = prefs.getInt(prefUserId).toString();
  Uri url = Uri.parse(notificationViewsUrl);
  Map body = {
    "P_READEDFLG": "1",
    "P_PATIENTID": patientId
};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      debugPrint(
          "messageViewUrl response.statusCode: ${response.statusCode}");
      return false;
    }
    debugPrint("messageViewUrl response.body: ${response.body}");
    return true;
  } catch (e) {
    debugPrint("messageViewUrl e: $e");
    return false;
  }
}