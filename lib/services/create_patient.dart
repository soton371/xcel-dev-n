import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

Future<bool> createPatient({
  required String patientName,
  required String dob,
  required String genderNo,
  required String bloodNo,
  required String religionId,
  required String maritalStatusId,
  required String nId,
  required String passportNo,
  required String voterId,
  required String mobileNo,
  required String email,
  required String countryId,
  required String ocupation,
  required String relationId,
  required String photoLoca
}) async {
  debugPrint("call createPatient");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String patientId = prefs.getInt(prefUserId).toString();
  Uri url = Uri.parse(cr8hcpatUrl);
  Map body = {
    "P_PARENTSID": patientId,
    "P_PATIENTNM": patientName,
    "P_DTOFBIRTH": dob,
    "P_SORGNDRNO": genderNo,
    "P_BLDGRP_NO": bloodNo,
    "P_RELGIONID": religionId,
    "P_MSTATUSID": maritalStatusId,
    "P_BIRTREGNO": voterId,
    "P_NATINALID": nId,
    "P_PASPORTNO": passportNo,
    "P_PMOBILENO": mobileNo,
    "P_PTEMAILNO": email,
    "P_OCUPATION": ocupation,
    "P_PTHOUSENO": "",
    "P_STREETNAM": "",
    "P_PTADDRESS": "",
    "P_ADDRESLOC": "",
    "P_REGIONNAM": "",
    "P_NOKINNAME": "",
    "P_RELTIONID": relationId,
    "P_KINMOBILE": "",
    "P_KINDGADRS": "",
    "P_PERFORMBY": "",
    "P_PHOTOLOCA": photoLoca,
    "P_PHOTOEXTN": "",
    "P_COUNTRYID" : countryId
  };
  debugPrint("body: $body");

   Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json'
     };
  try {
    final response = await http.post(url, headers: requestHeaders, body: json.encode(body));
    if (response.statusCode != 200) {
      debugPrint("createPatient response.statusCode: ${response.statusCode}");
      return false;
    }
    debugPrint("createPatient response.body: ${response.body}");
    return true;
  } catch (e) {
    debugPrint("createPatient e: $e");
    return false;
  }
}
