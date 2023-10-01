
import 'dart:convert';

Video videoFromJson(String str) =>Video.fromJson(json.decode(str));
String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  String? pRETRNMSG0;
  List<PRETRNMSG1>? pRETRNMSG1;

  Video({this.pRETRNMSG0, this.pRETRNMSG1});

  Video.fromJson(Map<String, dynamic> json) {
    pRETRNMSG0 = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      pRETRNMSG1 = [];
      json['P_RETRNMSG1'].forEach((v) {
        pRETRNMSG1!.add(PRETRNMSG1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSG0'] = pRETRNMSG0;
    if (pRETRNMSG1 != null) {
      data['P_RETRNMSG1'] = pRETRNMSG1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PRETRNMSG1 {
  int? videoId;
  String? vidTitle;
  String? vidDescription;
  String? vidDuration;
  String? vidUrl;
  String? topicUid;

  PRETRNMSG1(
      {this.videoId,
        this.vidTitle,
        this.vidDescription,
        this.vidDuration,
        this.vidUrl,
        this.topicUid});

  PRETRNMSG1.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    vidTitle = json['vid_title'];
    vidDescription = json['vid_description'];
    vidDuration = json['vid_duration'];
    vidUrl = json['vid_url'];
    topicUid = json['topic_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_id'] = videoId;
    data['vid_title'] = vidTitle;
    data['vid_description'] = vidDescription;
    data['vid_duration'] = vidDuration;
    data['vid_url'] = vidUrl;
    data['topic_uid'] = topicUid;
    return data;
  }
}
