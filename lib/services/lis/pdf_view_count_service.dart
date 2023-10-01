import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future pdfViewCounterService(String reqId, String testNo) async {
  Map data = {
    "P_REPVEW_CNT": 1,
    "P_INV_REQ_ID": reqId,
    "P_PL_INVT_ID": testNo,
  };
  var body = json.encode(data);
  String extUrl = 'report/vwcnt';
  Uri url = Uri.parse(baseUrlLis + extUrl);

  final http.Response response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  log(response.body);
  log(body);
  if (response.statusCode == 200 && response.body.isNotEmpty) {
    debugPrint('Count successfully sent!!!');
  } else {
    log('Count failed!!!');
  }
}
