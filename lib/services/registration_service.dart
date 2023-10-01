import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;

class RegistrationService {
  Future<dynamic> fetchCallInfo() async {
    String extUrl = 'callinfo';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.17:8888/ords/ordstest/xcel/callinfo";

    debugPrint('Contract Info URL:$url');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      log('Call info retrived successful!!!');
      return jsonDecode(response.body);
    } else {
      log('Call info retrived failed!!!');
    }
  }

  Future<dynamic> checkVersion() async {
    String extUrl = 'versioncheck';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://103.219.160.253:8088/ords/ati_xcel/xcel/versioncheck";

    debugPrint('version check URL:$url');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      log('version info retrieved successful!!!');
      return jsonDecode(response.body);
    } else {
      log('version info retrieved failed!!!');
    }
  }
}
