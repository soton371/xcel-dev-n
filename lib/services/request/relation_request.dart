import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

Future<Map> requestRelation(
    {required String patientId,required String requestForId,required String relationId}) async {
  debugPrint("call requestRelation");
  Map returnValue = {};
  Uri url = Uri.parse(reqreltnUrl);
  Map body = {
    "P_PATIENTID": patientId,
    "P_RQSTFORID": requestForId,
    "P_RELTIONID": relationId,
    "P_PERFORMBY": patientId
    };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      debugPrint("requestRelation response.statusCode: ${response.statusCode}");
      returnValue = {
        "status": "${response.statusCode}",
        "message": "Something went wrong."
      };
      return returnValue;
    }
    debugPrint("requestRelation response.body: ${response.body}");
    final jsonBody = json.decode(response.body);
    returnValue = {
      "status": "${jsonBody["P_RETRNMSGN"]}",
      "message": "${jsonBody["P_RETRNMSG0"]}"
    };
    return returnValue;
  } catch (e) {
    debugPrint("requestRelation e: $e");
    returnValue = {
        "status": "500",
        "message": "Something went wrong."
      };
    return  returnValue;
  }
}
