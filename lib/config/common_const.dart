// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';

Color primaryColor = Colors.green;
Color kBackgroundColor = const Color(0xFFe6f2ff);
Color greenLightColor = const Color(0xffebfaf3);
Color cRed = const Color(0xFFb9232c);
Color cSky = const Color(0xFF648fd6);
Color cViolet = const Color(0xFF34017e);
Color cYellow = const Color(0xFFada06b);
Color xcelSecColor = const Color(0xFFec892b);
Color textBlack = Colors.black;

/*-----------------------------------------------------Connection[HealthLineBd/XCEL]-----------------------------------------------------*/
//String liveUrlHealthline = 'https://bdhealthline.net/health-line-bd-ws/api/';
// String localUrlXcel = 'http://192.168.0.17:8888/ords/ordstest/xcel/';
String liveUrlXcel = 'http://103.219.160.253:8088/ords/ati_xcel/xcel/';
String testUrl = "http://192.168.0.144:8282/ords/ati_csms/csms/";
String multipartRequestLocalUrl ="http://192.168.0.29:8088";
String multipartRequestLiveUrl = "http://gpst.billingdil.com:8088";

// String baseUrl = testUrl;
// String multipartRequestBaseUrl = multipartRequestLocalUrl;
String baseUrl = liveUrlXcel;
String multipartRequestBaseUrl = multipartRequestLiveUrl;

String lookupUrl = "${baseUrl}lookup" ;
String rltnstusUrl = "${baseUrl}rltnstus" ;
String rltnaprvUrl = "${baseUrl}rltnaprv" ;
String patlistsUrl = "${baseUrl}patlists" ;
String reqreltnUrl = "${baseUrl}reqreltn" ;
String messagesUrl = "${baseUrl}messages" ;
// String msgviewsUrl = "${baseUrl}msgviews" ;
String notificationViewsUrl = "${baseUrl}msgviews" ;
String notificationReadUrl = "${baseUrl}msgreads" ;
String cr8hcpatUrl = "${baseUrl}cr8hcpat" ;
String usrupdUrl = "${baseUrl}usrupd" ;

String addProfileImageUrl = "$multipartRequestBaseUrl/ati_io_ws/api/file/save-multiple/1/XCEL/PROFILE?appName=Xcel Medical Centre";
String multipartRequestUrl = '$multipartRequestBaseUrl/ati_io_ws/api/file/save-multiple/1/XCEL/INVST?appName=Xcel Medical Centre';
String billistUrl = "${baseUrl}billist";
String investigationUrl = "${baseUrl}investigation";
String pathistoryUrl = "${baseUrl}pathistory";
String reqmedicineUrl = "${baseUrl}reqmedicine";
/*-----------------------------------------------------SharedPreferences-----------------------------------------------------*/
const String prefUserId = 'userId';
const String prefUserNo = 'userNo';
const String prefPatientName = 'patientName';
const String prefPatientMob = 'patientMob';
const String prefPatientEmail = 'patientEmail';
const String prefUserPass = 'userPass';
const String prefDob = 'dob';
const String prefBloodGroup = 'bloodGroup';
const String prefGender = 'gender';
const String prefUserPhoto = 'userPhoto';
const String prefRememberMe = 'rememberMe';
const String defaultImageUrl = 'https://cdn141.picsart.com/321556657089211.png';

/*-----------------------------------------------------Connection[LIS]-----------------------------------------------------*/
String baseUrlLis = 'http://192.168.0.54:8088/ords/ordstest/';

/*----------------------------------------------------- Input Type-----------------------------------------------------*/

const String TYPE_TEXT = "T";
const String TYPE_NUMBER = "N";
const String TYPE_PHONE = "P";
const String TYPE_EMAIL = "E";
const String TYPE_DATE = "D";

/*----------------------------------------------------- ASSET PATH -----------------------------------------------------*/
String defaultFemaleAssetImg = 'assets/images/ic_doctor.png';
String xcelLogo = 'assets/images/xcel_logo.png';

int pMobiapsId = Platform.isAndroid ? 1:2;