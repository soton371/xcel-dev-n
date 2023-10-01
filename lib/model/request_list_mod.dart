// To parse this JSON data, do
//
//     final requestListModel = requestListModelFromJson(jsonString);

import 'dart:convert';

RequestListModel requestListModelFromJson(String str) => RequestListModel.fromJson(json.decode(str));

String requestListModelToJson(RequestListModel data) => json.encode(data.toJson());

class RequestListModel {
    String? pRetrnmsgn;
    String? pRetrnmsg0;
    List<PRetrnmsg1>? pRetrnmsg1;

    RequestListModel({
        this.pRetrnmsgn,
        this.pRetrnmsg0,
        this.pRetrnmsg1,
    });

    factory RequestListModel.fromJson(Map<String, dynamic> json) => RequestListModel(
        pRetrnmsgn: json["P_RETRNMSGN"],
        pRetrnmsg0: json["P_RETRNMSG0"],
        pRetrnmsg1: json["P_RETRNMSG1"] == null ? [] : List<PRetrnmsg1>.from(json["P_RETRNMSG1"]!.map((x) => PRetrnmsg1.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "P_RETRNMSGN": pRetrnmsgn,
        "P_RETRNMSG0": pRetrnmsg0,
        "P_RETRNMSG1": pRetrnmsg1 == null ? [] : List<dynamic>.from(pRetrnmsg1!.map((x) => x.toJson())),
    };
}

class PRetrnmsg1 {
    int? requestId;
    int? rqstpatId;
    String? rqstpatNm;
    int? rqstforId;
    String? rqstforNm;
    int? statusFlg;
    // String? photoLoca;
    String? photoFrom;
    String? photoTo;
    String? performAt;
    String? statusDtl;
    String? approvRsn;
    String? cancelRsn;
    int? reltionId;
    String? reltnName;

    PRetrnmsg1({
        this.requestId,
        this.rqstpatId,
        this.rqstpatNm,
        this.rqstforId,
        this.rqstforNm,
        this.statusFlg,
        // this.photoLoca,
        this.photoFrom,
        this.photoTo,
        this.performAt,
        this.statusDtl,
        this.approvRsn,
        this.cancelRsn,
        this.reltionId,
        this.reltnName,
    });

    factory PRetrnmsg1.fromJson(Map<String, dynamic> json) => PRetrnmsg1(
        requestId: json["request_id"],
        rqstpatId: json["rqstpat_id"],
        rqstpatNm: json["rqstpat_nm"],
        rqstforId: json["rqstfor_id"],
        rqstforNm: json["rqstfor_nm"],
        statusFlg: json["status_flg"],
        // photoLoca: json["photo_loca"],
        photoFrom: json["photo_from"],
        photoTo: json["photo_to"],
        performAt: json["perform_at"],
        statusDtl: json["status_dtl"],
        approvRsn: json["approv_rsn"],
        cancelRsn: json["cancel_rsn"],
        reltionId: json["reltion_id"],
        reltnName: json["reltn_name"],
    );

    Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "rqstpat_id": rqstpatId,
        "rqstpat_nm": rqstpatNm,
        "rqstfor_id": rqstforId,
        "rqstfor_nm": rqstforNm,
        "status_flg": statusFlg,
        // "photo_loca": photoLoca,
        "photo_from": photoFrom,
        "photo_to": photoTo,
        "perform_at": performAt,
        "status_dtl": statusDtl,
        "approv_rsn": approvRsn,
        "cancel_rsn": cancelRsn,
        "reltion_id": reltionId,
        "reltn_name": reltnName,
    };
}
