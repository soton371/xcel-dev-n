import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../config/common_const.dart';
import '../model/appointment.dart';
import 'package:http/http.dart' as http;

class UpcomingAptService {
  Future<Appointment> getUpcomingAppointment(Map body) async {
    String extUrl = "upcoming";
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Upcoming Apt Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    // log(response.body);
    debugPrint("$body");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Upcoming Appointment data retrieved successful!!!');
      return appointmentFromJson(response.body);
    } else {
      log('Upcoming Appointment data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
