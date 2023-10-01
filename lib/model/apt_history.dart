
import 'dart:convert';

AptHistory aptHistoryFromJson(String data) => AptHistory.fromJson(json.decode(data));
class AptHistory {
  String? pRETRNMSGN;
  String? pRETRNMSG0;
  List<HistoryData>? pRETRNMSG1;

  AptHistory({this.pRETRNMSGN, this.pRETRNMSG0, this.pRETRNMSG1});

  AptHistory.fromJson(Map<String, dynamic> json) {
    pRETRNMSGN = json['P_RETRNMSGN'];
    pRETRNMSG0 = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      pRETRNMSG1 = [];
      json['P_RETRNMSG1'].forEach((v) {
        pRETRNMSG1!.add(HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSGN'] = pRETRNMSGN;
    data['P_RETRNMSG0'] = pRETRNMSG0;
    if (pRETRNMSG1 != null) {
      data['P_RETRNMSG1'] = pRETRNMSG1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  String? consultNo;
  String? consultBy;
  String? doctorName;
  String? serviceName;
  String? speciality;
  String? consultDt;
  String? consultTime;
  String? slNo;
  List<PatMedicine>? patMedicine;
  List<PatAdvice>? patAdvice;
  String? docSignature;
  int? medreqFlg;

  HistoryData(
      {
        this.consultNo,
        this.consultBy,
        this.doctorName,
        this.serviceName,
        this.speciality,
        this.consultDt,
        this.consultTime,
        this.slNo,
        this.patMedicine,
        this.patAdvice,
        this.docSignature,
        this.medreqFlg
      });

  HistoryData.fromJson(Map<String, dynamic> json) {
    consultNo = json['consult_no'];
    consultBy = json['consult_by'];
    doctorName = json['doctor_name'];
    serviceName = json['service_name'];
    speciality = json['speciality'];
    consultDt = json['consult_dt'];
    consultTime = json['consult_time'];
    slNo = json['sl_no'];
    if (json['pat_medicine'] != null) {
      patMedicine = [];
      json['pat_medicine'].forEach((v) {
        patMedicine!.add(PatMedicine.fromJson(v));
      });
    }
    if (json['pat_advice'] != null) {
      patAdvice = [];
      json['pat_advice'].forEach((v) {
        patAdvice!.add(PatAdvice.fromJson(v));
      });
    }
    docSignature = json['doc_signature'];
    medreqFlg = json['medreq_flg'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consult_no'] = consultNo;
    data['consult_by'] = consultBy;
    data['doctor_name'] = doctorName;
    data['service_name'] = serviceName;
    data['speciality'] = speciality;
    data['consult_dt'] = consultDt;
    data['consult_time'] = consultTime;
    data['sl_no'] = slNo;
    if (patMedicine != null) {
      data['pat_medicine'] = patMedicine!.map((v) => v.toJson()).toList();
    }
    if (patAdvice != null) {
      data['pat_advice'] = patAdvice!.map((v) => v.toJson()).toList();
    }
    data['doc_signature'] = docSignature;
    data['medreq_flg'] = medreqFlg ?? 0;
    return data;
  }
}

class PatMedicine {
  String? medicineName;
  String? freequency;
  String? instruction;
  String? useMathod;
  String? duration;
  double? price;

  PatMedicine(
      {this.medicineName,
        this.freequency,
        this.instruction,
        this.useMathod,
        this.duration,
        this.price});

  PatMedicine.fromJson(Map<String, dynamic> json) {
    medicineName = json['medicine_name'];
    freequency = json['freequency'];
    instruction = json['instruction'];
    useMathod = json['use_mathod'];
    duration = json['duration'];
    var prc = json['price'].toString();
    price =  double.parse(prc.isEmpty || 'null' == prc ?'0.0' : prc) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicine_name'] = medicineName;
    data['freequency'] = freequency;
    data['instruction'] = instruction;
    data['use_mathod'] = useMathod;
    data['duration'] = duration;
    data['price'] = price;
    return data;
  }
}

class PatAdvice {
  String? advice;

  PatAdvice({this.advice});

  PatAdvice.fromJson(Map<String, dynamic> json) {
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advice'] = advice;
    return data;
  }
}