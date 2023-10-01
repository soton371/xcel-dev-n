import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:xcel_medical_center/model/lookup_model.dart';

Future<bool> editProfile({
  required String patientName,
  required String mobileNo,
  required String mail,
  required String blood,
  required Set<Blood> gender,
  required String dob,
  required String photoPath,
  required String previewPhotoUrl
}) async {
  debugPrint("call editProfile");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userNo = prefs.getString(prefUserNo);
  Uri url = Uri.parse(usrupdUrl);
  
  Map body = {
   "P_USRLOGNID": userNo ?? '',
   "P_PATIENTNM": patientName,
   "P_PMOBILENO": mobileNo,
   "P_PTEMAILNO": mail,
   "P_SORGNDRNO": gender.first.rId,
   "P_BLDGRP_NO": blood,
   "P_DTOFBIRTH": dob,
   "P_PHOTOLOCA": photoPath
};
  Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json'
     };
  try {
    final response = await http.post(url, headers: requestHeaders, body: json.encode(body));
    if (response.statusCode != 200) {
      debugPrint("editProfile response.statusCode: ${response.statusCode}");
      return false;
    }
    debugPrint("editProfile response.body: ${response.body}");
    await prefs.setString(prefPatientName, patientName);
    await prefs.setString(prefPatientMob, mobileNo);
    await prefs.setString(prefPatientEmail, mail);
    await prefs.setString(prefGender, gender.first.rName??'');
    await prefs.setString(prefBloodGroup, blood);
    await prefs.setString(prefDob, dob);
    await prefs.setString(prefUserPhoto, previewPhotoUrl);
    return true;
  } catch (e) {
    debugPrint("editProfile e: $e");
    return false;
  }
}
