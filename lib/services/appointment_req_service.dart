import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

import '../model/appointment_req_data.dart';

class AppointmentRequestService {
  // static int statusCode;
  Future sendRequest(AppointmentReqData data) async {
    var body = json.encode(data);
    String extUrl = 'appoint';
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Appointment Req: ${url.toString()}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    debugPrint(body);
    // statusCode = response.statusCode;
    if (response.statusCode == 200) {
      log(response.body);
      return jsonDecode(response.body);
    } else {
      debugPrint(response.body);
      debugPrint("Unable to perform request!");
      Map err = {
        "P_RETRNMSG0" : "Failed"
      };
      return err;
    }
  }
}
