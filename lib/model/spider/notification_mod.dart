// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    int? messageId;
    String? mesagBody;
    int? viewedFlg;
    dynamic clickActn;
    String? enteredAt;

    NotificationModel({
        this.messageId,
        this.mesagBody,
        this.viewedFlg,
        this.clickActn,
        this.enteredAt
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        messageId: json["message_id"],
        mesagBody: json["mesag_body"],
        viewedFlg: json["viewed_flg"],
        clickActn: json["click_actn"],
        enteredAt: json["entered_at"],
    );

    Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "mesag_body": mesagBody,
        "viewed_flg": viewedFlg,
        "click_actn": clickActn,
        "entered_at": enteredAt,
    };
}
