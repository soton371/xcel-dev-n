import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import '../model/video.dart';
import '../model/video_param.dart';

class VideoService {
  Future<Video> fetchVideoInfo(VideoParam body) async {
    String extUrl = "vdolink";
    //     'video/get-permitted-videos?roleUid=P&topicUid=TIP&userId=52';
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('calling.....................');
    //Uri url = Uri.parse("https://bdhealthline.net/health-line-bd-ws/api/video/get-permitted-videos?roleUid=P&topicUid=TIP&userId=52");
    debugPrint('Video Url : $url');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()));
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Youtube video data retrieved successful!!!');
      return videoFromJson(response.body);
    } else {
      log('Youtube video data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
