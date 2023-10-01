import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/dialog_text_tile.dart';
import 'consultation_fee_dialog.dart';

class BookingReqSuccessDialog extends StatelessWidget {
  final String? doctorName;
  final String? patientName;
  final String? consultationDate;
  final String? status;
  final String? consultationFee;
  
  const BookingReqSuccessDialog({
    Key? key,
    @required this.doctorName,
    @required this.patientName,
    @required this.consultationDate,
    @required this.status,
    @required this.consultationFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)), //this right here
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Successful!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle_outlined, color: Colors.white, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Your request is accepted', style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.w400)),
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
                    DialogTextTile(title: 'Doctor Name          : ', value: doctorName??'', titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Patient Name         : ', value: patientName??'', titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Consultation Date : ', value: consultationDate??'', titleColor: Colors.green, valueColor: Colors.black),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DialogTextTile(title: 'Status                    : ', value: status??'', titleColor: Colors.red, valueColor: Colors.redAccent.shade100),
                    DialogTextTile(title: 'Consultation Fee : ', value: consultationFee??'', titleColor: Colors.red, valueColor: Colors.redAccent.shade100),
                    ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.red.shade100,
                ),
                child: const Text(
                  'Your Serial will not be Activated\n Until You Pay',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context){
                    return ConsultationFeeDialog(
                      doctorName: doctorName??'',
                      consultationDate: consultationDate??'',
                      consultationFee: 'GHC $consultationFee',
                      consultationTime: '10:30 PM',
                    );
                  },
                );
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
              child: const Text('Tap to Pay'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}