
class VideoParam {
  String? pPATIENTID;
  String? pTOPICUID;
  String? pROLEACID;

  VideoParam({this.pPATIENTID, this.pTOPICUID, this.pROLEACID});

  VideoParam.fromJson(Map<String, dynamic> json) {
    pPATIENTID = json['P_PATIENTID'];
    pTOPICUID = json['P_TOPIC_UID'];
    pROLEACID = json['P_ROLEAC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_PATIENTID'] = pPATIENTID;
    data['P_TOPIC_UID'] = pTOPICUID;
    data['P_ROLEAC_ID'] = pROLEACID;
    return data;
  }
}
