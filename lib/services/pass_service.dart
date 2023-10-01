import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../config/common_const.dart';
import 'package:http/http.dart' as http;
import '../model/password_dto.dart';

class PassService {
  Future changePassword(PasswordDto data) async {
    String extUrl = 'pwdchd';
    Uri url = Uri.parse(baseUrl + extUrl);
    // String url = "http://192.168.0.17:8888/ords/ordstest/xcel/pwdchd ";

    debugPrint('Password Change URL:$url');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data.toJson()),
    );
    // log(response.body);
    debugPrint("data: $data");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Password Change successful!!!');

      return jsonDecode(response.body);
    } else {
      Map err = {"P_RETURNMSG": "Password changed Failed!"};
      log('Password Change failed!!!');
      return err;
    }
  }
}
