// To parse this JSON data, do
//
//     final doctorCategoryModel = doctorCategoryModelFromJson(jsonString);

import 'dart:convert';

DoctorCategoryModel doctorCategoryModelFromJson(String str) =>
    DoctorCategoryModel.fromJson(json.decode(str));

String doctorCategoryModelToJson(DoctorCategoryModel data) =>
    json.encode(data.toJson());

class DoctorCategoryModel {
  DoctorCategoryModel({
    this.message,
    this.listResponse,
  });

  final String? message;
  final List<ListResponse>? listResponse;

  factory DoctorCategoryModel.fromJson(Map<String, dynamic> json) =>
      DoctorCategoryModel(
        message: json["message"],
        listResponse: List<ListResponse>.from(
            json["listResponse"].map((x) => ListResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "listResponse": List<dynamic>.from(listResponse!.map((x) => x.toJson())),
      };
}

class ListResponse {
  ListResponse({
    this.speciallityNo,
    this.speciality,
    this.doctorList,
  });

  final int? speciallityNo;
  final String? speciality;
  final List<DoctorList>? doctorList;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        speciallityNo: json["speciallityNo"],
        speciality: json["speciality"],
        doctorList: List<DoctorList>.from(
            json["doctorList"].map((x) => DoctorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "speciallityNo": speciallityNo,
        "speciality": speciality,
        "doctorList": List<dynamic>.from(doctorList!.map((x) => x.toJson())),
      };
}

class DoctorList {
  DoctorList({
    this.doctorNo,
    this.drCode,
    this.doctorName,
    this.bmdcRegNo,
    this.degree,
    this.specialityNo,
    this.departmentNo,
    this.instituteNo,
    this.currentChember,
    this.onLineChamberNo,
    this.degreeOther,
    this.callingId,
    this.callingPw,
    this.callingUid,
    this.specialityName,
    this.departmentName,
    this.instituteName,
    this.uid,
    this.chamber,
    this.imgPath,
  });

  final int? doctorNo;
  final String? drCode;
  final String? doctorName;
  final String? bmdcRegNo;
  final String? degree;
  final int? specialityNo;
  final int? departmentNo;
  final int? instituteNo;
  final int? currentChember;
  final int? onLineChamberNo;
  final String? degreeOther;
  final String? callingId;
  final String? callingPw;
  final String? callingUid;
  final String? specialityName;
  final String? departmentName;
  final String? instituteName;
  final int? uid;
  final Chamber? chamber;
  final String? imgPath;

  factory DoctorList.fromJson(Map<String, dynamic> json) => DoctorList(
        doctorNo: json["doctorNo"],
        drCode: json["drCode"],
        doctorName: json["doctorName"],
        bmdcRegNo: json["bmdcRegNo"],
        degree: json["degree"],
        specialityNo: json["specialityNo"],
        departmentNo: json["departmentNo"],
        instituteNo: json["instituteNo"],
        currentChember: json["currentChember"],
        onLineChamberNo: json["onLineChamberNo"],
        degreeOther: json["degreeOther"],
        callingId: json["callingId"],
        callingPw: json["callingPw"],
        callingUid: json["callingUid"],
        specialityName: json["specialityName"],
        departmentName: json["departmentName"],
        instituteName: json["instituteName"],
        uid: json["uid"],
        chamber:
            json["chamber"] == null ? null : Chamber.fromJson(json["chamber"]),
        imgPath: json["imgPath"],
      );

  Map<String, dynamic> toJson() => {
        "doctorNo": doctorNo,
        "drCode": drCode,
        "doctorName": doctorName,
        "bmdcRegNo": bmdcRegNo,
        "degree": degree,
        "specialityNo": specialityNo,
        "departmentNo": departmentNo,
        "instituteNo": instituteNo,
        "currentChember": currentChember,
        "onLineChamberNo": onLineChamberNo,
        "degreeOther": degreeOther,
        "callingId": callingId,
        "callingPw": callingPw,
        "callingUid": callingUid,
        "specialityName": specialityName,
        "departmentName": departmentName,
        "instituteName": instituteName,
        "uid": uid,
        "chamber": chamber == null ? null : chamber!.toJson(),
        "imgPath": imgPath,
      };
}

class Chamber {
  Chamber({
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
    this.chamberName,
  });

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
  final String? chamberName;

  factory Chamber.fromJson(Map<String, dynamic> json) => Chamber(
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
        chamberName: json["chamberName"],
      );

  Map<String, dynamic> toJson() => {
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
        "chamberName": chamberName,
      };
}
