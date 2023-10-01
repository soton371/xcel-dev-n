// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

List<UserListModel> userListModelFromJson(String str) => List<UserListModel>.from(json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListModelToJson(List<UserListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
    int? patientId;
    String? patIdTxt;
    String? patregDtm;
    String? patientNo;
    String? patientNm;
    dynamic sorgndrtxt;
    String? caldobTxt;
    String? calcptDob;
    String? caldobFmt;
    dynamic patageTxt;
    dynamic relgnName;
    dynamic mstusName;
    String? nationalid;
    dynamic nationalty;
    dynamic birthregno;
    dynamic bldgrpTxt;
    String? pmobileNo;
    dynamic prphoneNo;
    String? ptemailNo;
    String? occupation;
    dynamic pasportNo;
    String? ptAddress;
    dynamic photoLoca;
    String? patStatus;
    dynamic patRemark;
    String? ptDtaudtm;
    int? approvedfg;

    UserListModel({
        this.patientId,
        this.patIdTxt,
        this.patregDtm,
        this.patientNo,
        this.patientNm,
        this.sorgndrtxt,
        this.caldobTxt,
        this.calcptDob,
        this.caldobFmt,
        this.patageTxt,
        this.relgnName,
        this.mstusName,
        this.nationalid,
        this.nationalty,
        this.birthregno,
        this.bldgrpTxt,
        this.pmobileNo,
        this.prphoneNo,
        this.ptemailNo,
        this.occupation,
        this.pasportNo,
        this.ptAddress,
        this.photoLoca,
        this.patStatus,
        this.patRemark,
        this.ptDtaudtm,
        this.approvedfg,
    });

    factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        patientId: json["patient_id"],
        patIdTxt: json["pat_id_txt"],
        patregDtm: json["patreg_dtm"],
        patientNo: json["patient_no"],
        patientNm: json["patient_nm"],
        sorgndrtxt: json["sorgndrtxt"],
        caldobTxt: json["caldob_txt"],
        calcptDob: json["calcpt_dob"],
        caldobFmt: json["caldob_fmt"],
        patageTxt: json["patage_txt"],
        relgnName: json["relgn_name"],
        mstusName: json["mstus_name"],
        nationalid: json["nationalid"],
        nationalty: json["nationalty"],
        birthregno: json["birthregno"],
        bldgrpTxt: json["bldgrp_txt"],
        pmobileNo: json["pmobile_no"],
        prphoneNo: json["prphone_no"],
        ptemailNo: json["ptemail_no"],
        occupation: json["occupation"],
        pasportNo: json["pasport_no"],
        ptAddress: json["pt_address"],
        photoLoca: json["photo_loca"],
        patStatus: json["pat_status"],
        patRemark: json["pat_remark"],
        ptDtaudtm: json["pt_dtaudtm"],
        approvedfg: json["approvedfg"],
    );

    Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "pat_id_txt": patIdTxt,
        "patreg_dtm": patregDtm,
        "patient_no": patientNo,
        "patient_nm": patientNm,
        "sorgndrtxt": sorgndrtxt,
        "caldob_txt": caldobTxt,
        "calcpt_dob": calcptDob,
        "caldob_fmt": caldobFmt,
        "patage_txt": patageTxt,
        "relgn_name": relgnName,
        "mstus_name": mstusName,
        "nationalid": nationalid,
        "nationalty": nationalty,
        "birthregno": birthregno,
        "bldgrp_txt": bldgrpTxt,
        "pmobile_no": pmobileNo,
        "prphone_no": prphoneNo,
        "ptemail_no": ptemailNo,
        "occupation": occupation,
        "pasport_no": pasportNo,
        "pt_address": ptAddress,
        "photo_loca": photoLoca,
        "pat_status": patStatus,
        "pat_remark": patRemark,
        "pt_dtaudtm": ptDtaudtm,
        "approvedfg": approvedfg,
    };
}
