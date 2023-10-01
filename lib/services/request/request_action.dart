import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

Future<bool> requestAction(
    {required String requestId,required String statusFlag,required String performer}) async {
  debugPrint("call requestAction");
  Uri url = Uri.parse(rltnaprvUrl);
  Map body = {
    "P_REQUESTID": requestId,
    "P_STATUSFLG": statusFlag,
    "P_APPROVRSN": "",
    "P_PERFORMBY": performer
  };
  try {
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      debugPrint("requestAction response.statusCode: ${response.statusCode}");
      return false;
    }
    debugPrint("requestAction response.body: ${response.body}");
    return true;
  } catch (e) {
    debugPrint("requestAction e: $e");
    return  false;
  }
}
