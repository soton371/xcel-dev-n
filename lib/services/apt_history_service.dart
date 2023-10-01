import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:xcel_medical_center/model/apt_history.dart';
import '../config/common_const.dart';
import 'package:http/http.dart' as http;

class AptHistoryService {
  Future<AptHistory> getAppointmentHistory(Map body) async {
    debugPrint("Call getAppointmentHistory");
    Uri url = Uri.parse(pathistoryUrl);
    debugPrint('Apt History Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Appointment History data retrieved successful!!!');
      return aptHistoryFromJson(response.body);
    } else {
      log('Appointment History data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<Map> sendMedicineDeliveryReq(Map body) async {
    debugPrint("Call sendMedicineDeliveryReq");
    Uri url = Uri.parse(reqmedicineUrl);
    debugPrint('Req Medicine Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    debugPrint("body: $body");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint('Send medicine req successful!!!');
      return json.decode(response.body);
    } else {
      debugPrint('Send medicine req failed!!!');
      log(response.statusCode.toString());
      Map resData = {"P_RETRNMSGN": "500", "P_RETRNMSG0": "Submit Failed!!"};
      return resData;
    }
  }
}
