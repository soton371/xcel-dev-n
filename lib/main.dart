import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/blocs/lookup/lookup_bloc.dart';
import 'package:xcel_medical_center/blocs/notification/notification_bloc.dart';
import 'package:xcel_medical_center/blocs/request_list/request_list_bloc.dart';
import 'package:xcel_medical_center/blocs/user_list/user_list_bloc.dart';
import 'package:xcel_medical_center/services/notification/notification_ser.dart';
import 'pages/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationService().initNotification();
  runApp(
    MultiBlocProvider(providers: [
        BlocProvider<LookupBloc>(
          create: (BuildContext context) => LookupBloc(),
        ),
        BlocProvider<RequestListBloc>(
          create: (BuildContext context) => RequestListBloc(),
        ),
        BlocProvider<UserListBloc>(
          create: (BuildContext context) => UserListBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => NotificationBloc(),
        ),
      ], child: const MyApp())
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String spColorValue = '';
  String email = '';
  String saveUser = '';
  String? fcmToken;
  Future<void> getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("fcmToken main: $fcmToken");
  }

  @override
  void initState() {
    getFcmToken();
    NotificationService().msg(context);
    getValuesFromSP();
    super.initState();
    context.read<LookupBloc>().add(CallLookupService());
  }

  Future getValuesFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      spColorValue = prefs.getString('spColorValue').toString();
      email = prefs.getString('email') ?? '';
      saveUser = prefs.getString('saveUser') ?? '';
    });
    debugPrint("email: $email, saveUser: $saveUser");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xcel Medical Centre',
        theme: ThemeData(useMaterial3: true),
        home: SplashPage(
          email: email,
          saveUser: saveUser,
        ),
      
    );
  }
}
