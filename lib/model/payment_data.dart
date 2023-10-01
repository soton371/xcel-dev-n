
import 'dart:convert';

PaymentData paymentDataFromJson(String str) =>PaymentData.fromJson(json.decode(str));
String paymentDataToJson(PaymentData data) => json.encode(data.toJson());
class PaymentData {
  String? returnMsg0;
  List<DuePayData>? returnMsg1;

  PaymentData({this.returnMsg0, this.returnMsg1});

  PaymentData.fromJson(Map<String, dynamic> json) {
    returnMsg0 = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      returnMsg1 = [];
      json['P_RETRNMSG1'].forEach((v) {
        returnMsg1!.add(DuePayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSG0'] = returnMsg0;
    if (returnMsg1 != null) {
      data['P_RETRNMSG1'] = returnMsg1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DuePayData {
  int? reqBillId;
  String? consultNo;
  String? doctorService;
  int? billAmont;
  String? statusMsg;
  String? speciality;
  String? appointDate;
  String? appointTime;
  int? billAcceptFlag;
  int? payFlag;
  int? expireFlag;

  DuePayData(
      {this.reqBillId,
        this.consultNo,
        this.doctorService,
        this.billAmont,
        this.statusMsg,
        this.speciality,
        this.appointDate,
        this.appointTime,
        this.billAcceptFlag, // 0 = pending, 1 = accept, 2 = reject
        this.payFlag, // 0 = pending, 1= paid
        this.expireFlag
      });

  DuePayData.fromJson(Map<String, dynamic> json) {
    reqBillId = json['reqbill_id'];
    consultNo = json['consult_no'];
    doctorService = json['doctor_service'];
    billAmont = json['bill_amont'];
    statusMsg = json['status_msg'];
    speciality = json['speciality'];
    appointDate = json['appoint_date'];
    appointTime = json['appoint_time'];
    billAcceptFlag = json['bilacpt_fg'];
    payFlag = json['pay_flag'];
    expireFlag = json['expire_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqbill_id'] = reqBillId;
    data['consult_no'] = consultNo;
    data['doctor_service'] = doctorService;
    data['bill_amont'] = billAmont;
    data['status_msg'] = statusMsg;
    data['speciality'] = speciality;
    data['appoint_date'] = appointDate;
    data['appoint_time'] = appointTime;
    data['bilacpt_fg'] = billAcceptFlag;
    data['pay_flag'] = payFlag;
    data['expire_flag'] = expireFlag;
    return data;
  }
}
