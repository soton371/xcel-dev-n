import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/dialog_text_tile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/payment_page.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';

import '../../../../../../model/payment_data.dart';

class ConsultationFeeDialog extends StatelessWidget {
  final String? doctorName;
  final String? consultationDate;
  final String? consultationFee;
  final String? consultationTime;
  final DuePayData? data;
  const ConsultationFeeDialog({
    Key? key,
    @required this.doctorName,
    @required this.consultationDate,
    @required this.consultationFee,
    @required this.consultationTime,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: const Center(
                child: Text(
                  'Consultation Fee',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // DialogTextTile(title: 'Patient Name         : ', value: patientName, titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Doctor Name          : ', value: doctorName??'', titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Consultation Date : ', value: consultationDate??'', titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Consultation Time : ', value: consultationTime??'', titleColor: Colors.green, valueColor: Colors.black),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Consultation Fee',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DottedBorder(
                    color: Colors.black,
                    padding: const EdgeInsets.all(10),
                    strokeWidth: 1,
                    child: Text(
                      "GHC: $consultationFee",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
              btnColor: primaryColor, btnText: 'Pay Now', onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage(consultationFee: consultationFee??'', payData : data ?? DuePayData())),
                );
              },),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
