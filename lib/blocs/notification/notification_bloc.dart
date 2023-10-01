import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import 'package:xcel_medical_center/model/spider/notification_mod.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<CallNotificationEvent>((event, emit) async {
      debugPrint("call CallNotificationEvent");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String patientId = prefs.getInt(prefUserId).toString();
      Uri url = Uri.parse(messagesUrl);
      Map body = {"P_PATIENTID": patientId};
      try {
        final response = await http.post(url, body: body);
        if (response.statusCode != 200) {
          debugPrint(
              "fetchNotification response.statusCode: ${response.statusCode}");
          emit(const NotificationCountState(
              newNotificationCount: '0', notificationList: []));
        }
        final data = json.decode(response.body);
        String jsonString = json.encode(data['P_RETRNMSG1']).toString();
        List<NotificationModel> notificationList =
            notificationModelFromJson(jsonString);
        emit(NotificationCountState(
            newNotificationCount: "${data['P_NEWMSGCNT']}",
            notificationList: notificationList));
      } catch (e) {
        debugPrint("fetchNotification e: $e");
        emit(const NotificationCountState(
              newNotificationCount: '0', notificationList: []));
      }
    });

    //add for notification clear event
    on<NotificationClearEvent>((event, emit) async {
      emit(NotificationInitial());
    });
  }
}
