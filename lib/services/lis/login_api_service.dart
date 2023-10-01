import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/lis/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class APIService {
  /*-------------------------------- LIS LOGIN --------------------------------*/
  Future lisLogin(LoginRequestModelLIS requestModel) async {
    try {
      String extUrl = 'login';
      Uri url = Uri.parse(baseUrl + extUrl);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        log('body: [${response.body}]');
        prefs.setString('apiresp', response.body);
        debugPrint("Login response.body: ${response.body}");
        return json.decode(response.body);
      } else {
        debugPrint('Invalid credentials or connection problem');
      }
    } catch (e) {
      debugPrint("e: $e");
    }
  }
}
