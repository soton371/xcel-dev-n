import 'dart:convert';
import 'dart:developer';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import '../model/dept_doctor.dart';

class DoctorCategoryService {
  Future<DeptDoctor> getDeptWiseDoctorList() async {
    Uri url = Uri.parse('${baseUrl}deptdoctor');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    log(response.body);
    if (response.statusCode == 200) {
      log('Doctor category data retrived successful!!!');
      return decodeDepDoctorDataFromJson(response.body);
    } else {
      log('Doctor category data retrived failed!!!');
      return jsonDecode(response.body);
    }
  }
}
