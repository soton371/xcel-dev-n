import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../config/common_const.dart';
import '../model/pay_gateway.dart';
import '../model/payment_data.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<PaymentData> getDuePaymentList(Map body) async {
    debugPrint("call getDuePaymentList");
    Uri url = Uri.parse(billistUrl);
    debugPrint('Due Payment Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    debugPrint("$body");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Due Payment data retrieved successful!!!');
      return paymentDataFromJson(response.body);
    } else {
      log('Due Payment data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<PayGateway> getPayGateway(Map body) async {
    String extUrl = "gateway";
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Payment Gateway Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    // log(response.body);
    debugPrint("$body");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Payment gateway data retrieved successful!!!');
      return paymentGatewayDataFromJson(response.body);
    } else {
      log('Payment gateway data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> submitPayment(Map body) async {
    String extUrl = "billsubmit";
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Payment Submit Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    // log(response.body);
    debugPrint("$body");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint('Payment submit successful!!!');
      return jsonDecode(response.body);
    } else {
      debugPrint('Payment submit failed!!!');
      debugPrint(response.statusCode.toString());
      Map<String, dynamic> error = {
        "P_RETRNMSG0": "Something went wrong",
        "P_RETRNMSGN": response.statusCode.toString()
      };
      return error;
    }
  }
}
