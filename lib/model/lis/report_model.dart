import 'dart:convert';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    this.pReturnmsg0,
  });

  final List<PReturnmsg0>? pReturnmsg0;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        pReturnmsg0: List<PReturnmsg0>.from(
            json["P_RETURNMSG0"].map((x) => PReturnmsg0.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "P_RETURNMSG0": List<dynamic>.from(pReturnmsg0!.map((x) => x.toJson())),
      };
}

class PReturnmsg0 {
  PReturnmsg0({
    this.invReqId,
    this.voucherId,
    this.voucherDt,
    this.patientNo,
    this.patientNm,
    this.dtofBirth,
    this.photoLoca,
    this.consultNo,
    this.admsionNo,
    this.refBy,
    this.gender,
    this.totalReport,
    this.pendingReport,
    this.totalSample,
    this.collectedSample,
    this.totalInstruction,
    this.rptDtl,
  });

  final int? invReqId;
  final String? voucherId;
  final String? voucherDt;
  final String? patientNo;
  final String? patientNm;
  final DateTime? dtofBirth;
  final String? photoLoca;
  final String? consultNo;
  final String? admsionNo;
  final String? refBy;
  final String? gender;
  final int? totalReport;
  final int? pendingReport;
  final int? totalSample;
  final int? collectedSample;
  final int? totalInstruction;
  final List<RptDtl>? rptDtl;

  factory PReturnmsg0.fromJson(Map<String, dynamic> json) => PReturnmsg0(
        invReqId: json["inv_req_id"],
        voucherId: json["voucher_id"] ?? '',
        voucherDt: json["voucher_dt"] ?? '',
        patientNo: json["patient_no"] ?? '',
        patientNm: json["patient_nm"] ?? '',
        dtofBirth: json["dtof_birth"] ?? '',
        photoLoca: json["photo_loca"] ?? '',
        consultNo: json["consult_no"] ?? '',
        admsionNo: json["admsion_no"] ?? '',
        refBy: json["ref_by"] ?? '',
        gender: json["gender"] ?? '',
        totalReport: json["total_report"],
        pendingReport: json["pending_report"],
        totalSample: json["total_sample"],
        collectedSample: json["collected_sample"],
        totalInstruction: json["total_instruction"],
        rptDtl:
            List<RptDtl>.from(json["rpt_dtl"].map((x) => RptDtl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inv_req_id": invReqId,
        "voucher_id": voucherId,
        "voucher_dt": voucherDt,
        "patient_no": patientNo,
        "patient_nm": patientNm,
        "dtof_birth": dtofBirth,
        "photo_loca": photoLoca,
        "consult_no": consultNo,
        "admsion_no": admsionNo,
        "ref_by": refBy,
        "gender": gender,
        "total_report": totalReport,
        "pending_report": pendingReport,
        "total_sample": totalSample,
        "collected_sample": collectedSample,
        "total_instruction": totalInstruction,
        "rpt_dtl": List<dynamic>.from(rptDtl!.map((x) => x.toJson())),
      };
}

class RptDtl {
  RptDtl({
    this.testNo,
    this.department,
    this.reportTitle,
    this.reptDate,
    this.status,
    this.deliveryDate,
    this.reportNo,
    this.sampleDate,
    this.instruction,
    this.reptLink,
  });

  final String? testNo;
  final String? department;
  final String? reportTitle;
  final String? reptDate;
  final int? status;
  final String? deliveryDate;
  final String? reportNo;
  final String? sampleDate;
  final String? instruction;
  final String? reptLink;

  factory RptDtl.fromJson(Map<String, dynamic> json) => RptDtl(
        testNo: json["test_no"] ?? '',
        department: json["department"] ?? '',
        reportTitle: json["report_title"] ?? '',
        reptDate: json["rept_date"] ?? '',
        status: json["status"],
        deliveryDate: json["delivery_date"] ?? '',
        reportNo: json["report_no"] ?? '',
        sampleDate: json["sample_date"] ?? '',
        instruction: json["instruction"] ?? '',
        reptLink: json["rept_link"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "test_no": testNo,
        "department": department,
        "report_title": reportTitle,
        "rept_date": reptDate,
        "status": status,
        "delivery_date": deliveryDate,
        "report_no": reportNo,
        "sample_date": sampleDate,
        "instruction": instruction,
        "rept_link": reptLink,
      };
}
