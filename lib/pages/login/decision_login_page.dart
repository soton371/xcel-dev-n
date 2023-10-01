import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:xcel_medical_center/animation/animate_widget.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/login/patient/patient_login_page_hlbd.dart';
import 'package:xcel_medical_center/widgets/clipping_class.dart';
import 'package:xcel_medical_center/widgets/decision_card.dart';
import '../../services/registration_service.dart';
import '../navbar_patient/bottom_navbar_patient.dart';

class DecisionLogin extends StatefulWidget {
  const DecisionLogin({super.key});

  @override
  DecisionLoginState createState() => DecisionLoginState();
}

class DecisionLoginState extends State<DecisionLogin> {
  @override
  void initState() {
    debugPrint("from splash screen");
    checkRememberMe(context);
    super.initState();
  }

  void checkVersion(context) {
    RegistrationService().checkVersion().then((value) async {
      debugPrint('checkVersion value: $value');
      int isAndroid = Platform.isAndroid ? 0:1;
      var serverVersionName = value['items'][isAndroid]['ma_version'];
      var code = value['items'][isAndroid]['maver_code'];
      int serverVersionCode = code ?? 0;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int versionCode = int.parse(packageInfo.buildNumber);
      debugPrint(
          'serverVersionName : $serverVersionName serverVersionCode :$serverVersionCode');
      debugPrint('version code: $versionCode');
      debugPrint('packageInfo version name: ${packageInfo.version}');
      debugPrint("serverVersionCode: $serverVersionCode versionCode: $versionCode");
      if (serverVersionCode == versionCode) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBarPatient()),
          (route) => false,
        );
      } else if (serverVersionCode > versionCode) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.confirm,
            confirmBtnText: 'Update',
            cancelBtnText: 'Cancel',
            confirmBtnColor: Colors.green,
            onConfirmBtnTap: () {
              StoreRedirect.redirect(androidAppId: "com.xcel.medical", iOSAppId: "6449455026");
              Navigator.pop(context);
            },
            title: "Good news!!",
            text:
                'New version is available. Please update the app for better performance');
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            text: 'Maintenance Break. We Working on Server Please wait.....');
      }
    });
  }

  Future<void> checkRememberMe(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool remember = prefs.getBool(prefRememberMe) ?? false;
    debugPrint("======remember====$remember");
    if (remember) {
      checkVersion(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: ClipPath(
              clipper: ClippingClass(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: height * 0.65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/xceldoctor.jpg"), //doc.png
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.08,
            top: height * 0.08,
            child: AnimateWidget(
              beginSize: 70.0,
              endSize: 100.0,
              child: Image.asset(xcelLogo),
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.transparent, Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.04,
            left: width * 0.15,
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightGreen,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Take control of your health...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 40),
                DecisionCard(
                  title: 'Login As Patient',
                  fontSize: 22,
                  imagePath: 'assets/images/patient.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PatientLoginPageHLBD();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
