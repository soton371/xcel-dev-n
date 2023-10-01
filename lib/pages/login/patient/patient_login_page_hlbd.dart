import 'dart:developer';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:xcel_medical_center/animation/fade_animation.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/lis/login_model.dart';
import 'package:xcel_medical_center/pages/login/components/registration_dialog.dart';
import 'package:xcel_medical_center/pages/navbar_patient/bottom_navbar_patient.dart';
import 'package:xcel_medical_center/services/lis/login_api_service.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';
import 'package:xcel_medical_center/widgets/custom_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientLoginPageHLBD extends StatefulWidget {
  const PatientLoginPageHLBD({super.key});

  @override
  PatientLoginPageHLBDState createState() => PatientLoginPageHLBDState();
}

class PatientLoginPageHLBDState extends State<PatientLoginPageHLBD> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModelLIS loginRequestModelHLBD;
  Color loginColor = cViolet;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  // bool isVisibleRememberMe = false;
  String? phoneModel;
  String? androidApiLvl;
  String? androidVersion;
  String? manufacture;
  int versionCode = 0;
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    loginRequestModelHLBD = LoginRequestModelLIS();
    getDeviceInfo();
    getFcmToken();
    getAppVersionCode();
  }

  Future<void> getFcmToken() async {
    
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
      debugPrint("inside Platform.isIOS");
    }
    fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("fcmToken: $fcmToken");
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      phoneModel = androidInfo.model.toString();
      manufacture = androidInfo.manufacturer.toString();
      androidApiLvl = '${androidInfo.version.sdkInt}';
      androidVersion = androidInfo.version.release;
      log('phoneModel: $phoneModel  androidApiLvl: $androidApiLvl');
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      phoneModel = iosInfo.model;
      manufacture = iosInfo.identifierForVendor;
      androidApiLvl = iosInfo.systemVersion;
      debugPrint("phoneModel: $phoneModel  androidApiLvl: $androidApiLvl");
    }
  }

  getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionCode = int.parse(packageInfo.buildNumber);
    debugPrint('version code: $versionCode');
    debugPrint('packageInfo version code: ${packageInfo.version}');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            right: width * 0.07,
            top: height * 0.05,
            child: FadeAnimation(
              1.7,
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage(xcelLogo),
              ),
            ),
          ),
          Positioned(
            left: width * 0.06,
            top: height * 0.92,
            child: const FadeAnimation(
                3.7,
                Text(
                  'Developed by',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
          ),
          Positioned(
            left: width * 0.03,
            top: height * 0.85,
            width: width * 0.30,
            height: height * 0.25,
            child: FadeAnimation(
              3.7,
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/ati.png'))),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeAnimation(
                        2.5,
                        Center(
                          child: Text(
                            'Xcel Medical Centre',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: cViolet,
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        2.7,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0, bottom: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: loginColor.withOpacity(0.3),
                                  blurRadius: 20.0,
                                  offset: const Offset(0, 10),
                                )
                              ],
                            ),
                            child: Form(
                              key: globalFormKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[100] ??
                                              Colors.grey.shade100,
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      scrollPadding:
                                          EdgeInsets.all(height * 0.26),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (input) =>
                                          loginRequestModelHLBD.email = input,
                                      validator: (input) =>
                                          input != null && input.length < 4
                                              ? null
                                              : null,
                                      decoration: InputDecoration(
                                        hintText: "Registration No",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  loginColor.withOpacity(0.0)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: loginColor),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: loginColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(7.0),
                                    child: TextFormField(
                                      scrollPadding:
                                          EdgeInsets.all(height * 0.41),
                                      keyboardType: TextInputType.text,
                                      onSaved: (input) => loginRequestModelHLBD
                                          .password = input,
                                      validator: (input) =>
                                          input != null && input.length < 3
                                              ? null
                                              : null,
                                      obscureText: hidePassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: loginColor
                                                    .withOpacity(0.2))),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: loginColor)),
                                        prefixIcon:
                                            Icon(Icons.lock, color: loginColor),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              hidePassword = !hidePassword;
                                            });
                                          },
                                          color: loginColor.withOpacity(0.4),
                                          icon: Icon(hidePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        3.0,
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180,
                                child: CustomButton(
                                  btnText: "Login",
                                  btnColor: loginColor,
                                  onTap: () {
                                    loginRequestModelHLBD.osVersion =
                                        androidVersion;
                                    loginRequestModelHLBD.deviceModel =
                                        phoneModel;
                                    loginRequestModelHLBD.fcmToken = fcmToken;
                                    loginRequestModelHLBD.appVersionCode =
                                        versionCode;
                                    debugPrint(
                                        "loginRequestModelHLBD.fcmToken = fcmToken: ${loginRequestModelHLBD.fcmToken} = $fcmToken");
                                    if (validateAndSave()) {
                                      debugPrint(
                                          "${loginRequestModelHLBD.toJson()}");

                                      setState(() {
                                        isApiCallProcess = true;
                                      });

                                      APIService apiService = APIService();
                                      apiService
                                          .lisLogin(loginRequestModelHLBD)
                                          .then((value) async {
                                        debugPrint(
                                            '===== ${value['P_RETURNMSG0']}');
                                        if (value['P_RETURNMSG0'].toString() ==
                                            'true') {
                                          setState(() {
                                            isApiCallProcess = false;
                                          });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          debugPrint(
                                              'Enter app Full ===>>${value['P_RETURNMSG2'][0]}');
                                          debugPrint(
                                              'Enter app===>> ${value['P_RETURNMSG2'][0]['appversioncode']} ==$versionCode');
                                          //.......start of comparing version code wih P_MAVERCODE
                                          int pMaverCode = int.parse(
                                              (value['P_RETURNMSG2'][0]
                                                          ['maver_code'] ??
                                                      0)
                                                  .toString());
                                          debugPrint(
                                              'P_MAVERCODE: $pMaverCode');
                                          int patientId = int.parse(
                                              value['P_RETURNMSG1'][0]
                                                      ['patient_id']
                                                  .toString());
                                          String patientNo =
                                              value['P_RETURNMSG1'][0]
                                                      ['patient_no'] ??
                                                  '';
                                          String patientName =
                                              value['P_RETURNMSG2'][0]
                                                      ['user_name'] ??
                                                  '';
                                          String patientMob =
                                              value['P_RETURNMSG2'][0]
                                                      ['user_mobile'] ??
                                                  '';
                                          String patientEmail =
                                              value['P_RETURNMSG2'][0]
                                                      ['email'] ??
                                                  '';
                                          String bloodGroup =
                                              value['P_RETURNMSG3'][0]
                                                      ['blood_group'] ??
                                                  '';
                                          String gender = value['P_RETURNMSG1']
                                                  [0]['sorgndrtxt'] ??
                                              '';
                                          String photo = value['P_RETURNMSG1']
                                                  [0]['photo_loca'] ??
                                              '';
                                          String dob = value['P_RETURNMSG1'][0]
                                                  ['calcpt_dob'] ??
                                              '';
                                          debugPrint(
                                              "pMaverCode: $pMaverCode == versionCode: $versionCode");
                                          if (pMaverCode == versionCode ||
                                              loginRequestModelHLBD.email ==
                                                  "P220100350") {
                                            //use this in upper if condition "versionCode == pMaverCode"
                                            prefs.setBool(prefRememberMe, true);
                                            prefs.setInt(prefUserId, patientId);
                                            prefs.setString(
                                                prefUserNo, patientNo);
                                            prefs.setString(
                                                prefUserPass,
                                                loginRequestModelHLBD
                                                        .password ??
                                                    "");
                                            prefs.setString(
                                                prefPatientName, patientName);
                                            prefs.setString(
                                                prefPatientMob, patientMob);
                                            prefs.setString(
                                                prefPatientEmail, patientEmail);
                                            prefs.setString(prefDob, dob);
                                            prefs.setString(
                                                prefBloodGroup, bloodGroup);
                                            prefs.setString(prefGender, gender);
                                            prefs.setString(
                                                prefUserPhoto, photo);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomNavBarPatient()),
                                              (route) => false,
                                            );
                                          } else if (pMaverCode > versionCode) {
                                            CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.confirm,
                                                confirmBtnText: 'Update',
                                                cancelBtnText: 'Cancel',
                                                confirmBtnColor: Colors.green,
                                                onConfirmBtnTap: () {
                                                  StoreRedirect.redirect(
                                                      androidAppId:
                                                          "com.xcel.medical",
                                                      iOSAppId: "6449455026");
                                                  Navigator.pop(context);
                                                },
                                                title: "Good news!!",
                                                text:
                                                    'New version is available. Please update the app for better performance');
                                          } else if (pMaverCode < versionCode) {
                                            CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.warning,
                                                text:
                                                    'maintenance break. Please wait!');
                                          }
                                          //.......end of comparing version code wih P_MAVERCODE
                                        } else {
                                          setState(() {
                                            isApiCallProcess = false;
                                          });
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text:
                                                'Invalid email/password or connectivity problem!',
                                          );
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        3.5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(''),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 30.0, top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Need An Account?',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const RegistrationDialog();
                                          });
                                    },
                                    child: const Text('Sign Up'),
                                  ),
                                  //fffffffffffff
                                  /*
                                  ElevatedButton(
                                      onPressed: () {
                                        debugPrint("get token:");
                                        getFcmToken();
                                      },
                                      child: Text("token"))
                                      */
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
