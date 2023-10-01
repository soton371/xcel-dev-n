// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    String? patientName;
    String? patientMob;
    String? patientPhoto;
    String? patientEmail;
    String? userNo;
    String? userId;
    String? userPass;
    String? dob;
    String? bloodGroup;
    String? gender;
    String? userPhoto;

    UserInfoModel({
        this.patientName,
        this.patientMob,
        this.patientPhoto,
        this.patientEmail,
        this.userNo,
        this.userId,
        this.userPass,
        this.dob,
        this.bloodGroup,
        this.gender,
        this.userPhoto,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        patientName: json["patientName"],
        patientMob: json["patientMob"],
        patientPhoto: json["patientPhoto"],
        patientEmail: json["patientEmail"],
        userNo: json["userNo"],
        userId: json["userId"],
        userPass: json["userPass"],
        dob: json["dob"],
        bloodGroup: json["bloodGroup"],
        gender: json["gender"],
        userPhoto: json["userPhoto"],
    );

    Map<String, dynamic> toJson() => {
        "patientName": patientName,
        "patientMob": patientMob,
        "patientPhoto": patientPhoto,
        "patientEmail": patientEmail,
        "userNo": userNo,
        "userId": userId,
        "userPass": userPass,
        "dob": dob,
        "bloodGroup": bloodGroup,
        "gender": gender,
        "userPhoto": userPhoto,
    };
}
