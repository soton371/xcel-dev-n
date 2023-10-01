import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcel_medical_center/blocs/request_list/request_list_bloc.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/login/patient/patient_login_page_hlbd.dart';
import 'package:xcel_medical_center/pages/navbar_patient/bottom_navbar_patient.dart';
import 'package:xcel_medical_center/pages/navbar_patient/create_patients/create_patients_scr.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/about_us_dialog.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/contact_us_dialog.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/legal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/pages/navbar_patient/tag_request/tag_request_scr.dart';
import 'custom_side_menu.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:store_redirect/store_redirect.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  bool isLoading = true;
  String? patientName;
  String? patientNo;
  String? patientId;
  String? patientPhoto;
  String defaultImageUrl = 'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg';

  Future<void> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    patientName = prefs.getString(prefPatientName);
    patientNo = prefs.getString(prefUserNo);
    patientPhoto = prefs.getString(prefUserPhoto);
    patientId = prefs.getInt(prefUserId).toString();
  }

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[cViolet, Colors.blue]),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: isLoading
                      ? Container()
                      : Column(
                        children: <Widget>[
                          patientPhoto != null && patientPhoto!.isNotEmpty?
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(patientPhoto??defaultImageUrl),
                          ):
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/images/avatar.png"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                patientName??'',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                patientNo??'',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                ),
              ),
            ),
            CustomListTile(
              icon: CupertinoIcons.house,
              text: 'Dashboard',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBarPatient()),
                  (route) => false,
                );
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.person_2,
              text: 'Create Patients',
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (_)=> const CreatePatientScreen()));
              },
            ),
            //add for tag request
            CustomListTile(
              icon: CupertinoIcons.tag,
              text: 'Tag Request',
              onTap: () {
                context.read<RequestListBloc>().add(CallRequestList(patientId ?? ''));
                Navigator.push(context, CupertinoPageRoute(builder: (_)=> TagRequestScreen(performerId: patientId ?? '',)));
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.phone,
              text: 'Contact Us',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ContactUsDialog();
                  },
                );
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.info_circle,
              text: 'About Us',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AboutUsDialog();
                  },
                );
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.checkmark_shield,
              text: 'Legal',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const LegalDialog();
                  },
                );
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.star,
              text: 'Rate Us',
              onTap: () {
                StoreRedirect.redirect(androidAppId: "com.xcel.medical", iOSAppId: "6449455026");
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.share,
              text: 'Share App',
              onTap: () async {
                await FlutterShare.share(
                  title: 'Share Xcel Medical Centre',
                  text: 'Share Xcel Medical Centre with your friends and family',
                  linkUrl: Platform.isAndroid ? 'https://play.google.com/store/apps/details?id=com.xcel.medical' : "https://apps.apple.com/us/app/xcel-medical-centre/id6449455026",
                  chooserTitle: 'Share Xcel Medical Centre',
                );
              },
            ),
            CustomListTile(
              icon: CupertinoIcons.power,
              text: 'Logout',
              onTap: () {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: 'Do you want to logout?',
                    confirmBtnText: "Logout",
                    showCancelBtn: true,
                    onConfirmBtnTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('email');
                      prefs.remove('saveUser');
                      prefs.remove(prefRememberMe);
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) => const PatientLoginPageHLBD(),
                        ),
                      );
                    });
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
