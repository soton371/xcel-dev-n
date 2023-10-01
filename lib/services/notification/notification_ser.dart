import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xcel_medical_center/blocs/notification/notification_bloc.dart';
import 'package:xcel_medical_center/blocs/request_list/request_list_bloc.dart';
import 'package:xcel_medical_center/blocs/user_list/user_list_bloc.dart';
import 'package:xcel_medical_center/pages/navbar_patient/bottom_navbar_patient.dart';
import '../../blocs/lookup/lookup_bloc.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'consultation', // id
    'Video Conference', // title
    description:
        'Notify patient When Doctor Start Video Conference', // description
    importance: Importance.high,
  );

  Future<void> initNotification() async {
    //for android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_logo');
    //for ios
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        String clickAction = details.payload ?? "null";
        debugPrint("clickAction : $clickAction");
        if (clickAction.isNotEmpty &&
            clickAction.startsWith("OPEN_CONSULTATION_PAGE")) {
          goToSpecificPage(clickAction);
        }
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        String clickAction = details.payload ?? "null2";
        debugPrint("clickAction2 : $clickAction");
        if (clickAction.isNotEmpty &&
            clickAction.startsWith("OPEN_CONSULTATION_PAGE")) {
          goToSpecificPage(clickAction);
        }
      },
    );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            icon: "app_logo",
            importance: Importance.max),
        iOS: const DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, notificationDetails(),
        payload: payload);
  }

  Future<void> msg(BuildContext context) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

// onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // myToast("Open app from notification onMessage");
      String? title = message.notification?.title;
      String? body = message.notification?.body;
      String? payload = message.data['clickAction'];
      NotificationService()
          .showNotification(title: title, body: body, payload: payload);
      //here call event for new notification on screen shows
      context.read<NotificationBloc>().add(CallNotificationEvent());
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // myToast("Open app from notification onMessageOpenedApp");
      String clickAction = message.data["clickAction"];
      goToSpecificPage(clickAction);
      
    });

    //add for app open from kill state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // myToast("Open app from getInitialMessage");
      if (message != null) {
        String clickAction = message.data["clickAction"];
        goToSpecificPage(clickAction);
      }
    });
  }

  void goToSpecificPage(String? payload) {
    if (payload != null) {
      String clickAction = payload;
      debugPrint("clickAction : $clickAction");
      if (clickAction.isNotEmpty &&
          clickAction.startsWith("OPEN_CONSULTATION_PAGE")) {
        runApp(MultiBlocProvider(
            providers: [
              BlocProvider<LookupBloc>(
                create: (BuildContext context) => LookupBloc(),
              ),
              BlocProvider<RequestListBloc>(
                create: (BuildContext context) => RequestListBloc(),
              ),
              BlocProvider<UserListBloc>(
                create: (BuildContext context) => UserListBloc(),
              ),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(useMaterial3: true),
                home: const BottomNavBarPatient(
                  switchTabIndex: 1,
                  appointmentTabIndex: 0,
                ))));
      }
    }
  }
}
