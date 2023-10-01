
import 'dart:convert';

PayGateway paymentGatewayDataFromJson(String str) =>PayGateway.fromJson(json.decode(str));
String paymentGatewayDataToJson(PayGateway data) => json.encode(data.toJson());
class PayGateway {
  String? pRETRNMSG0;
  List<PayGatewayData>? pRETRNMSG1;

  PayGateway({this.pRETRNMSG0, this.pRETRNMSG1});

  PayGateway.fromJson(Map<String, dynamic> json) {
    pRETRNMSG0 = json['P_RETRNMSG0'];
    if (json['P_RETRNMSG1'] != null) {
      pRETRNMSG1 = [];
      json['P_RETRNMSG1'].forEach((v) {
        pRETRNMSG1!.add(PayGatewayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_RETRNMSG0'] = pRETRNMSG0;
    if (pRETRNMSG1 != null) {
      data['P_RETRNMSG1'] = pRETRNMSG1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayGatewayData {
  String? gatewayRefNo;
  String? payInstructions;
  String? payGatewayName;
  int? isPaid;
  String? payGatewayUdNo;
  int? payGatewayNo;
  String? gatewayType;
  String? momoId;
  String? merchantNo;
  List<Insurance>? insurance;

  PayGatewayData(
      {this.gatewayRefNo,
        this.payInstructions,
        this.payGatewayName,
        this.isPaid,
        this.payGatewayUdNo,
        this.payGatewayNo,
        this.gatewayType,
        this.momoId,
        this.merchantNo,
        this.insurance
      });

  PayGatewayData.fromJson(Map<String, dynamic> json) {
    gatewayRefNo = json['gateway_ref_no'];
    payInstructions = json['pay_instructions'];
    payGatewayName = json['pay_gateway_name'];
    isPaid = json['is_paid'];
    payGatewayUdNo = json['pay_gateway_ud_no'];
    payGatewayNo = json['pay_gateway_no'];
    gatewayType = json['gateway_type'];
    momoId = json['momo_id'];
    merchantNo = json['merchant_no'];
    if (json['insurance'] != null) {
      insurance = [];
      json['insurance'].forEach((v) {
        insurance!.add(Insurance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway_ref_no'] = gatewayRefNo;
    data['pay_instructions'] = payInstructions;
    data['pay_gateway_name'] = payGatewayName;
    data['is_paid'] = isPaid;
    data['pay_gateway_ud_no'] = payGatewayUdNo;
    data['pay_gateway_no'] = payGatewayNo;
    data['gateway_type'] = gatewayType;
    data['momo_id'] = momoId;
    data['merchant_no'] = merchantNo;
    if (insurance != null) {
      data['insurance'] = insurance!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Insurance {
  int? payGatewayChdNo;
  String? payGatewayChdName;
  String? companyType;

  Insurance({this.payGatewayChdNo, this.payGatewayChdName});

  Insurance.fromJson(Map<String, dynamic> json) {
    payGatewayChdNo = json['pay_gatewaychd_no'];
    payGatewayChdName = json['pay_gatewaychd_name'];
    companyType = json['company_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pay_gatewaychd_no'] = payGatewayChdNo;
    data['pay_gatewaychd_name'] = payGatewayChdName;
    data['company_type'] = companyType;
    return data;
  }

  String gatewayAsString() {
    return '$payGatewayChdName';
  }
}
