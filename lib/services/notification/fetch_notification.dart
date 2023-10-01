import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:xcel_medical_center/model/spider/notification_mod.dart';

Future<Map> fetchNotification() async {
  debugPrint("call fetchNotification");
  Map value = {"new_notification": "0","notifications":[]};
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String patientId = prefs.getInt(prefUserId).toString();
  Uri url = Uri.parse(messagesUrl);
  Map body = {"P_PATIENTID": patientId};
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      debugPrint(
          "fetchNotification response.statusCode: ${response.statusCode}");
          value = {"new_notification": "0","notifications":[]};
      return value;
    }
    final data = json.decode(response.body);
    String jsonString = json.encode(data['P_RETRNMSG1']).toString();
    List<NotificationModel> notificationList =
        notificationModelFromJson(jsonString);
        value = {"new_notification": "${data['P_NEWMSGCNT']}","notifications": notificationList};
    return value;
  } catch (e) {
    debugPrint("fetchNotification e: $e");
    value = {"new_notification": "0","notifications":[]};
    return value;
  }
}
