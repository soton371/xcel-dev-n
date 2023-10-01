import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/utils/date_time_utils.dart';

import '../../../../dialogs/dialog_medicine_req.dart';
import '../../../../model/apt_history.dart';
import '../../../../services/registration_service.dart';

class PrescriptionView extends StatefulWidget {
  final HistoryData? data;
  final OnCloseListener? listener;

  const PrescriptionView({Key? key, @required this.data, @required this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrescriptionView();
}

typedef OnCloseListener = void Function(bool isSendSuccess);
// typedef void OnCloseListener(bool isSendSuccess);

class _PrescriptionView extends State<PrescriptionView>{
  String? patName;
  String? bloodGroup = "";
  String? gender = "";
  String dob = "";
  String successMsg = "";
  var callInfo;
  bool isLoading = true;
  String phn1 = "";
  String phn2 = "";
  @override
  void initState() {
    getUserDetails();
    RegistrationService().fetchCallInfo().then((value) {
      setState(() {
        callInfo = value;
        isLoading = false;
        setState(() {
          phn1 = callInfo['items'][0]['rx_contact1'].toString();
          phn2 = callInfo['items'][0]['rx_contact2'].toString();
        });
      });
    });
    super.initState();
  }



  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      patName = prefs.getString(prefPatientName);
      bloodGroup = prefs.getString(prefBloodGroup);
      gender = prefs.getString(prefGender);
      final birthDate = prefs.getString(prefDob);
      if(birthDate != null && birthDate.isNotEmpty){
        final fromDt = DateTime.parse(birthDate);
        final today = DateTime.now();
        final days = daysBetween(fromDt, today);
        final monthDays = days % 365;
        final year = ((days - monthDays) / 365).round();
        final daysRemaining = monthDays % 30;
        final month = ((monthDays - daysRemaining) / 30).round();

        dob = "$year Y - $month M - $daysRemaining D";
      }

    });

  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    HistoryData? data2 = widget.data;
    String? doctorName = data2 != null? data2.doctorName : "" ;
    String? speciality = data2 != null? data2.speciality: "" ;
    int? medReqFlag = data2 != null? data2.medreqFlg : 0;
    String date = DateTimeUtils().convertStringDateFormat( data2 != null? data2.consultDt??'' : '', EEE_DD_MMM_YYYY) ;
    List<PatAdvice> adviceList = data2 != null? data2.patAdvice??[]:[];
    String advice = "";
    if(adviceList.isNotEmpty){
      for(var a in adviceList){
        advice += "${a.advice}\n";
      }
    }


    return InteractiveViewer(
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(30),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'XCEL MEDICAL CENTRE',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/delete.png', height: 18, width: 18),
                      ),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Text('P.O.Box,11719,Accra North', style: TextStyle(fontSize: 13)),
                Text('Mob: $phn1/$phn2', style: const TextStyle(fontSize: 13)),
                const Text('Email: xcelmedicalcentre@gmail.com', style: TextStyle(fontSize: 13)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Prescription',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor, decoration: TextDecoration.underline),
                  ),
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(successMsg, style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),),
                )),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (medReqFlag??0) > 0 || (data2?.patMedicine) == null || data2!.patMedicine!.isEmpty ? Container(
                      child: (medReqFlag??0) > 0 && (data2?.patMedicine) != null && data2!.patMedicine!.isNotEmpty? Row(children: [
                        Image.asset('assets/images/check_mark.png', height: 35, width: 35),
                        const Text('Requested', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green)),
                      ]) : Container(),
                    ) : ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context){

                            return DialogMedicineReq(
                              doctorName :doctorName,
                              doctorDesignation: speciality,
                              medicineList : data2.patMedicine,
                              data: widget.data,
                              callback: (success){
                                if(success){
                                  setState(() {
                                    successMsg = "Successfully sent delivery request!";
                                  });
                                  widget.listener!(true);
                                  Navigator.pop(context);
                                }
                              },
                            );

                          },
                        );
                      },
                      //hide for real scenario
                      child: Text("Request for Delivery",style: TextStyle(color: primaryColor),)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(doctorName??'', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        Text(speciality??'', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                Divider(color: primaryColor, thickness: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Patient Name: $patName', style: const TextStyle(fontSize: 13)),
                    Text('Gender: $gender, Age: $dob , BG: $bloodGroup', style: const TextStyle(fontSize: 13)),
                  ],
                ),
                Container(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Table(
                    // defaultColumnWidth: FixedColumnWidth(width * 0.5 - 40),
                      border: TableBorder.all(color: primaryColor, width: 2),
                      columnWidths: const {
                        0: FlexColumnWidth(3.0),
                        1: FlexColumnWidth(1.0),
                      },
                      children: getPrescriptionTableRow(data2 != null? data2.patMedicine??[]:[])
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Advice: ',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "\n$advice", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Date: ',
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: date, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const Column(
                      children: [
                        Text('Signed', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


List<TableRow> getPrescriptionTableRow(List<PatMedicine> medicinList) {
  List<TableRow> childs = [];
  if(medicinList.isNotEmpty){

    // FIRST ROW ADDED IN "childs" LIST
    childs.add(
      const TableRow(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('Prescribed Items', textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text('Frequency', textAlign: TextAlign.center),
          ),
        ],
      ),
    );

    // MIDDLE ROW ADDED IN "childs" LIST
    double total = 0;

    for(var m in medicinList){
      double price = m.price ?? 0;
      total = total + price;
      childs.add(
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 16, 0, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.medicineName ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),

                        RichText(
                          text: TextSpan(
                            text: 'M. Of Admin: ',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: m.useMathod ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'Instruction: ',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: m.instruction ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 16, 0, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(text: m.freequency ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: '',
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(text: m.duration ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
      ]));
    }

  }

  return childs;
}