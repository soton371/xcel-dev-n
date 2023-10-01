

class AppointmentReqData {
  int? patientId;
  String? appontDate;
  String? appontType;
  String? slotNumber;
  String? startTime;
  String? endTime;
  String? deptNumber;
  String? doctorNo;
  String? consultRoomNo;
  String? enteredBy;
  String? companyNo;
  double? serviceRate;

  AppointmentReqData(
      {this.patientId,
        this.appontDate,
        this.appontType,
        this.slotNumber,
        this.startTime,
        this.endTime,
        this.deptNumber,
        this.doctorNo,
        this.consultRoomNo,
        this.enteredBy,
        this.companyNo,
        this.serviceRate});

  AppointmentReqData.fromJson(Map<String, dynamic> json) {
    patientId = json['P_PATIENTID'];
    appontDate = json['P_APPONT_DT'];
    appontType = json['P_APPONT_TP'];
    slotNumber = json['P_SLOT_NUMR'];
    startTime = json['P_SSTR_TIME'];
    endTime = json['P_SEND_TIME'];
    deptNumber = json['P_DEPT_NMBR'];
    doctorNo = json['P_DOCTOR_NO'];
    consultRoomNo = json['P_CONSUL_RM'];
    enteredBy = json['P_ENTERD_BY'];
    companyNo = json['P_COMPANYNO'];
    serviceRate = json['P_SERVICERT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_PATIENTID'] = patientId;
    data['P_APPONT_DT'] = appontDate;
    data['P_APPONT_TP'] = appontType;
    data['P_SLOT_NUMR'] = slotNumber;
    data['P_SSTR_TIME'] = startTime;
    data['P_SEND_TIME'] = endTime;
    data['P_DEPT_NMBR'] = deptNumber;
    data['P_DOCTOR_NO'] = doctorNo;
    data['P_CONSUL_RM'] = consultRoomNo;
    data['P_ENTERD_BY'] = enteredBy;
    data['P_COMPANYNO'] = companyNo;
    data['P_SERVICERT'] = serviceRate;
    return data;
  }
}
