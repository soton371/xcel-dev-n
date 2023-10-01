
import 'dart:convert';

Investigation investigationFromJson(String data) => Investigation.fromJson(json.decode(data));
class Investigation {
  String? statusCode;
  String? message;
  List<ConsultInfo>? consultInfo;

  Investigation({this.statusCode, this.message, this.consultInfo});

  Investigation.fromJson(Map<String, dynamic> json) {
    statusCode = json['P_RETRNMSGN'];
    message = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      consultInfo = [];
      json['P_RETRNMSG1'].forEach((v) {
        consultInfo!.add(ConsultInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSGN'] = statusCode;
    data['P_RETRNMSG0'] = message;
    if (consultInfo != null) {
      data['P_RETRNMSG1'] = consultInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConsultInfo {
  String? consultNo;
  String? consultBy;
  String? doctorName;
  String? serviceName;
  String? speciality;
  String? consultDt;
  String? consultTime;
  String? slNo;
  String? consultTypeNo;
  List<Investigations>? investigations;

  ConsultInfo(
      {this.consultNo,
        this.consultBy,
        this.doctorName,
        this.serviceName,
        this.speciality,
        this.consultDt,
        this.consultTime,
        this.slNo,
        this.consultTypeNo,
        this.investigations});

  ConsultInfo.fromJson(Map<String, dynamic> json) {
    consultNo = json['consult_no'];
    consultBy = json['consult_by'];
    doctorName = json['doctor_name'];
    serviceName = json['service_name'];
    speciality = json['speciality'];
    consultDt = json['consult_dt'];
    consultTime = json['consult_time'];
    slNo = json['sl_no'];
    consultTypeNo = json['consult_type_no'];
    if (json['investigations'] != null) {
      investigations = [];
      json['investigations'].forEach((v) {
        investigations!.add(Investigations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consult_no'] = consultNo;
    data['consult_by'] = consultBy;
    data['doctor_name'] = doctorName;
    data['service_name'] = serviceName;
    data['speciality'] = speciality;
    data['consult_dt'] = consultDt;
    data['consult_time'] = consultTime;
    data['sl_no'] = slNo;
    data['consult_type_no'] = consultTypeNo;
    if (investigations != null) {
      data['investigations'] =
          investigations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Investigations {
  int? investigationId;
  String? testNo;
  String? testName;
  String? instruction;
  int? uploadFlag;

  Investigations(
      {this.investigationId, this.testNo, this.testName, this.instruction});

  Investigations.fromJson(Map<String, dynamic> json) {
    investigationId = json['investigation_id'];
    testNo = json['test_no'];
    testName = json['test_name'];
    instruction = json['instruction'];
    uploadFlag = json['upload_flg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['investigation_id'] = investigationId;
    data['test_no'] = testNo;
    data['test_name'] = testName;
    data['instruction'] = instruction;
    data['upload_flg'] = uploadFlag;
    return data;
  }
}
