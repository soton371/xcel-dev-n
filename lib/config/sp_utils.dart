import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /* :::::::::::::::::::::::::::::::: login response [DOCTOR] ::::::::::::::::::::::::::::::::::*/
  Future<bool> setLoginResp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('loginRespHealthLineBd', value);
  }

  Future<String> getLoginResp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginRespHealthLineBd') ?? '';
  }

  Future<bool> setDrName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drName', value);
  }

  Future<String> getDrName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drName') ?? '';
  }

  Future<bool> setDrEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drEmail', value);
  }

  Future<String> getDrEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drEmail') ?? '';
  }
  Future<bool> setDrMobileNo(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drMobileNo', value);
  }

  Future<String> getDrMobileNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drMobileNo') ?? '';
  }

  Future<bool> setDrRegNo(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drRegNo', value);
  }

  Future<String> getDrRegNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drRegNo') ?? '';
  }

  Future<bool> setDrDegree(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drDegree', value);
  }

  Future<String> getDrDegree() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drDegree') ?? '';
  }

  Future<bool> setDrDept(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drDept', value);
  }

  Future<String> getDrDept() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drDept') ?? '';
  }

  Future<bool> setDrProfileImg(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drProfileImg', value);
  }

  Future<String> getDrProfileImg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drProfileImg') ?? '';
  }

  Future<bool> setDrSignImg(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('drSignImg', value);
  }

  Future<String> getDrSignImg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('drSignImg') ?? '';
  }
  /* :::::::::::::::::::::::::::::::: login response [DOCTOR] ::::::::::::::::::::::::::::::::::*/

  //selected visiting card
  Future<bool> setVisitingCard(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('visitingCard', value);
  }

  Future<String> getVisitingCard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('visitingCard') ?? '';
  }

  //selected visiting card Color
  Future<bool> setVisitingCardColor(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('visitingCardColor', value);
  }

  Future<String> getVisitingCardColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('visitingCardColor') ?? '';
  }

  /* :::::::::::::::::::::::::::::::: FULL LOGIN RESPONSE PATIENT LOGIN :::::::::::::::::::::::::::::::: */
  Future<bool> setPatientLoginResp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('patient_login_resp', value);
  }

  Future<String> getPatientLoginResp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('patient_login_resp') ?? '';
  }
}
