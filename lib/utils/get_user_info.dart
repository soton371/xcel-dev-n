import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/spider/user_info_mod.dart';

Future<UserInfoModel> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String patientName = prefs.getString(prefPatientName) ?? '';
    String patientMob = prefs.getString(prefPatientMob) ?? '';
    String patientPhoto = prefs.getString(prefUserPhoto) ?? defaultImageUrl;
    String patientEmail = prefs.getString(prefPatientEmail) ?? '';
    int userIdInt = prefs.getInt(prefUserId) ?? 0;
    String userId = userIdInt.toString();
    String userNo = prefs.getString(prefUserNo) ?? '';
    String userPass = prefs.getString(prefUserPass) ?? '';
    String dob = prefs.getString(prefDob) ?? '';
    String bloodGroup = prefs.getString(prefBloodGroup) ?? '';
    String gender = prefs.getString(prefGender) ?? '';
    String userPhoto = prefs.getString(prefUserPhoto) ?? '';

    UserInfoModel userInfo = UserInfoModel(
      patientName: patientName,
      patientMob: patientMob,
      patientPhoto: patientPhoto,
      patientEmail: patientEmail,
      userPass: userPass,
      userId: userId,
      gender: gender,
      bloodGroup: bloodGroup,
      dob: dob,
      userNo: userNo,
      userPhoto: userPhoto
    );
    
    return userInfo;
  }