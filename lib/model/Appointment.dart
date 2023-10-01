
import 'dart:convert';

Appointment appointmentFromJson(String str) =>Appointment.fromJson(json.decode(str));
String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  String? pRETRNMSG0;
  List<AppointmentData>? pRETRNMSG1;
  String? pRETRNMSGN;

  Appointment({this.pRETRNMSG0, this.pRETRNMSG1, this.pRETRNMSGN});

  Appointment.fromJson(Map<String, dynamic> json) {
    pRETRNMSG0 = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      pRETRNMSG1 = [];
      json['P_RETRNMSG1'].forEach((v) {
        pRETRNMSG1!.add(AppointmentData.fromJson(v));
        
      });
    }
    pRETRNMSGN = json['P_RETRNMSGN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSG0'] = pRETRNMSG0;
    if (pRETRNMSG1 != null) {
      data['P_RETRNMSG1'] = pRETRNMSG1!.map((v) => v.toJson()).toList();
    }
    data['P_RETRNMSGN'] = pRETRNMSGN;
    return data;
  }
}

class AppointmentData {
  String? consultNo;
  String? consultBy;
  String? doctorName;
  String? serviceName;
  String? consultDt;
  String? consultTime;
  String? slNo;
  String? speciality;
  String? jitsiRoomNo;
  String? consultTypeNo;

  AppointmentData(
      {this.consultNo,
        this.consultBy,
        this.doctorName,
        this.serviceName,
        this.consultDt,
        this.consultTime,
        this.slNo,
        this.speciality,
        this.jitsiRoomNo,
        this.consultTypeNo
      });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    consultNo = json['consult_no'];
    consultBy = json['consult_by'];
    doctorName = json['doctor_name'];
    serviceName = json['service_name'];
    consultDt = json['consult_dt'];
    consultTime = json['consult_time'];
    slNo = json['sl_no'];
    speciality = json['speciality'];
    jitsiRoomNo = json['con_vd_call'];
    consultTypeNo = json['consult_type_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consult_no'] = consultNo;
    data['consult_by'] = consultBy;
    data['doctor_name'] = doctorName;
    data['service_name'] = serviceName;
    data['consult_dt'] = consultDt;
    data['consult_time'] = consultTime;
    data['sl_no'] = slNo;
    data['speciality'] = speciality;
    data['con_vd_call'] = jitsiRoomNo;
    data['consult_type_no'] = consultTypeNo;
    return data;
  }
}
