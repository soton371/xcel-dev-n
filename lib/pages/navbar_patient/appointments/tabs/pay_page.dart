import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/appointments/components/pay_tile.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/dialog/consultation_fee_dialog.dart';

import '../../../../model/payment_data.dart';
import '../../../../services/payment_service.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  _PayPage createState() => _PayPage();
}

class _PayPage extends State<PayPage> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DuePayData> dueDataList = [];

  @override
  void initState() {
    super.initState();
    getDuePaymentData();
  }

  Future<void> getDuePaymentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map body = {
      "P_PATIENTID": prefs.getInt(prefUserId),
      "P_RETRNMSG0": "",
      "P_RETRNMSG1": ""
    };
    PaymentService().getDuePaymentList(body).then((value) {
      List<DuePayData>? dataList = value.returnMsg1;
      if (dataList != null && dataList.isNotEmpty) {
        dueDataList.addAll(dataList);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      body: isLoading
          ? Center(
              child: Image.asset(
                'assets/images/loader.gif',
                height: 100,
              ),
            )
          : dueDataList.isEmpty ? const Center(child: Text("There are currently no dues"),):
          ListView.builder(
              itemCount: dueDataList.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                DuePayData data = dueDataList[index];
                return PayTile(
                  appointmentDate: "${data.appointDate} - ${data.appointTime}",
                  doctorName: data.doctorService,
                  serviceName: data.speciality,
                  consultationFee: 'GHC: ${data.billAmont.toString()}',
                  data: data,
                  msg: data.statusMsg,
                  onTapPay: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConsultationFeeDialog(
                            doctorName: data.doctorService ?? '',
                            consultationDate: "${data.appointDate}",
                            consultationFee: data.billAmont.toString(),
                            consultationTime: data.appointTime ?? '',
                            data: data);
                      },
                    );
                  },
                );
              }),
    );
  }
}
