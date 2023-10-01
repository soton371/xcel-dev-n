// To parse this JSON data, do
//
//     final doctorChamberModel = doctorChamberModelFromJson(jsonString);

import 'dart:convert';

DoctorChamberModel doctorChamberModelFromJson(String str) =>
    DoctorChamberModel.fromJson(json.decode(str));

String doctorChamberModelToJson(DoctorChamberModel data) =>
    json.encode(data.toJson());

class DoctorChamberModel {
  DoctorChamberModel({
    this.message,
    this.objResponse,
  });

  final String? message;
  final ObjResponse? objResponse;

  factory DoctorChamberModel.fromJson(Map<String, dynamic> json) =>
      DoctorChamberModel(
        message: json["message"],
        objResponse: ObjResponse.fromJson(json["objResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "objResponse": objResponse!.toJson(),
      };
}

class ObjResponse {
  ObjResponse({
    this.chamberNo,
    this.doctorNo,
    this.instittuteNo,
    this.contactNo,
    this.otherInfo,
    this.sat,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.startTime,
    this.endTime,
    this.duration,
    this.payExpiry,
    this.aptLimit,
    this.needApr,
    this.aptPrfReq,
    this.aptPrfReqTime,
    this.payMethod,
    this.needRefFg,
    this.overReqFg,
    this.refExpiredDay,
    this.enteredBy,
    this.consultMediaNo,
    this.drConsultFeeList,
    this.consultTimeList,
  });

  final int? chamberNo;
  final int? doctorNo;
  final int? instittuteNo;
  final String? contactNo;
  final String? otherInfo;
  final int? sat;
  final int? sun;
  final int? mon;
  final int? tue;
  final int? wed;
  final int? thu;
  final int? fri;
  final String? startTime;
  final String? endTime;
  final int? duration;
  final int? payExpiry;
  final int? aptLimit;
  final int? needApr;
  final int? aptPrfReq;
  final int? aptPrfReqTime;
  final int? payMethod;
  final int? needRefFg;
  final int? overReqFg;
  final int? refExpiredDay;
  final int? enteredBy;
  final int? consultMediaNo;
  final List<DrConsultFeeList>? drConsultFeeList;
  final List<ConsultTimeList>? consultTimeList;

  factory ObjResponse.fromJson(Map<String, dynamic> json) => ObjResponse(
        chamberNo: json["chamberNo"],
        doctorNo: json["doctorNo"],
        instittuteNo: json["instittuteNo"],
        contactNo: json["contactNo"],
        otherInfo: json["otherInfo"],
        sat: json["sat"],
        sun: json["sun"],
        mon: json["mon"],
        tue: json["tue"],
        wed: json["wed"],
        thu: json["thu"],
        fri: json["fri"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        duration: json["duration"],
        payExpiry: json["payExpiry"],
        aptLimit: json["aptLimit"],
        needApr: json["needApr"],
        aptPrfReq: json["aptPrfReq"],
        aptPrfReqTime: json["aptPrfReqTime"],
        payMethod: json["payMethod"],
        needRefFg: json["needRefFg"],
        overReqFg: json["overReqFg"],
        refExpiredDay: json["refExpiredDay"],
        enteredBy: json["enteredBy"],
        consultMediaNo: json["consultMediaNo"],
        drConsultFeeList: json["drConsultFeeList"] == null
            ? null
            : List<DrConsultFeeList>.from(json["drConsultFeeList"]
                .map((x) => DrConsultFeeList.fromJson(x))),
        consultTimeList: json["consultTimeList"] == null
            ? null
            : List<ConsultTimeList>.from(json["consultTimeList"]
                .map((x) => ConsultTimeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chamberNo": chamberNo,
        "doctorNo": doctorNo,
        "instittuteNo": instittuteNo,
        "contactNo": contactNo,
        "otherInfo": otherInfo,
        "sat": sat,
        "sun": sun,
        "mon": mon,
        "tue": tue,
        "wed": wed,
        "thu": thu,
        "fri": fri,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
        "payExpiry": payExpiry,
        "aptLimit": aptLimit,
        "needApr": needApr,
        "aptPrfReq": aptPrfReq,
        "aptPrfReqTime": aptPrfReqTime,
        "payMethod": payMethod,
        "needRefFg": needRefFg,
        "overReqFg": overReqFg,
        "refExpiredDay": refExpiredDay,
        "enteredBy": enteredBy,
        "consultMediaNo": consultMediaNo,
        "drConsultFeeList": drConsultFeeList == null
            ? null
            : List<dynamic>.from(drConsultFeeList!.map((x) => x.toJson())),
        "consultTimeList": consultTimeList ?? List<dynamic>.from(consultTimeList!.map((x) => x.toJson())),
      };
}

class ConsultTimeList {
  ConsultTimeList({
    this.consultTimeNo,
    this.chamberNo,
    this.consultDayNo,
    this.maxSlot,
    this.visitStart,
    this.visitEnd,
  });

  final int? consultTimeNo;
  final int? chamberNo;
  final int? consultDayNo;
  final int? maxSlot;
  final String? visitStart;
  final String? visitEnd;

  factory ConsultTimeList.fromJson(Map<String, dynamic> json) =>
      ConsultTimeList(
        consultTimeNo: json["consultTimeNo"],
        chamberNo: json["chamberNo"],
        consultDayNo: json["consultDayNo"],
        maxSlot: json["maxSlot"],
        visitStart: json["visitStart"],
        visitEnd: json["visitEnd"],
      );

  Map<String, dynamic> toJson() => {
        "consultTimeNo": consultTimeNo,
        "chamberNo": chamberNo,
        "consultDayNo": consultDayNo,
        "maxSlot": maxSlot,
        "visitStart": visitStart,
        "visitEnd": visitEnd,
      };
}

class DrConsultFeeList {
  DrConsultFeeList({
    this.consultTimeNo,
    this.chamberNo,
    this.consultType,
    this.consultFee,
  });

  final int? consultTimeNo;
  final int? chamberNo;
  final int? consultType;
  final double? consultFee;

  factory DrConsultFeeList.fromJson(Map<String, dynamic> json) =>
      DrConsultFeeList(
        consultTimeNo: json["consultTimeNo"],
        chamberNo: json["chamberNo"],
        consultType: json["consultType"],
        consultFee: json["consultFee"],
      );

  Map<String, dynamic> toJson() => {
        "consultTimeNo": consultTimeNo,
        "chamberNo": chamberNo,
        "consultType": consultType,
        "consultFee": consultFee,
      };
}
