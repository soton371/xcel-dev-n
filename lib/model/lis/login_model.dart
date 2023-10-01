import 'package:xcel_medical_center/config/common_const.dart';

class LoginRequestModelLIS {
  String? email;
  String? password;
  int? appVersionCode;
  String? deviceModel;
  String? osVersion;
  String? fcmToken;

  LoginRequestModelLIS({
    this.email,
    this.password,
    this.appVersionCode,
    this.deviceModel,
    this.osVersion,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "P_MOBIAPS_ID": "$pMobiapsId",
      "P_USRLOGINID": "$email",
      "P_UPASSWORDS": "$password",
      "P_MA_VERSION": appVersionCode.toString(),
      "P_MDEV_MODEL": deviceModel ?? '',
      "P_OS_VERSION": osVersion ?? '',
      "P_FCM_REG_ID": fcmToken ?? '',
    };

    return map;
  }
}

//login request model[healthline bd]
class LoginRequestModelHLBD {
  int? androidApiLvl;
  String? androidVersion;
  String? fcmToken;
  String? manufacture;
  String? userLoginId;
  String? phoneModel;
  String? userPass;
  String? userType;

  LoginRequestModelHLBD({
    this.androidApiLvl,
    this.androidVersion,
    this.fcmToken,
    this.manufacture,
    this.userLoginId,
    this.phoneModel,
    this.userPass,
    this.userType,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "P_USRLOGINID" : userLoginId ?? "",
      "P_UPASSWORDS" : userPass ?? "",
      "P_MOBIAPS_ID" : "$pMobiapsId",
      "P_MA_VERSION" : androidVersion ?? "",
      "P_MAVER_CODE": "12",
      "P_MDEV_MODEL" : phoneModel ?? "",
      "P_FCM_REG_ID" : fcmToken ?? "",
      "P_MSVCP_CMPY" : "",
      "P_OS_VERSION" : androidApiLvl ?? "",
    };

    return map;
  }
}
