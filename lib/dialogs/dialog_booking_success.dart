import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/dialog_text_tile.dart';

import '../pages/navbar_patient/bottom_navbar_patient.dart';


class DialogBookingSuccess extends StatelessWidget {
  final String? doctorName;
  final String? consultationDate;
  final String? status;
  final String? consultationFee;

  const DialogBookingSuccess({
    Key? key,
    this.doctorName,
    this.consultationDate,
    this.status,
    this.consultationFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)), //this right here
      child: SingleChildScrollView(
        child: Column(
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
                  Text('Booking Successful', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle_outlined, color: Colors.white, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Your Request is accepted, Please pay within 20 minutes to keep your slot', style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400)),
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
                    DialogTextTile(title: 'Doctor Name          : ', value: doctorName ?? '', titleColor: Colors.green, valueColor: Colors.black),
                    //  DialogTextTile(title: 'Patient Name         : ', value: patientName, titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Consultation Date : ', value: consultationDate ?? '', titleColor: Colors.green, valueColor: Colors.black),
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
                    DialogTextTile(title: 'Status                    : ', value: status ?? '', titleColor: Colors.black, valueColor: Colors.green),
                    DialogTextTile(title: 'Consultation Fee : ', value: "GHC: $consultationFee", titleColor: Colors.black, valueColor: Colors.green),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Cancel",style: TextStyle(color: Colors.white),)
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        child: const Text("Go to payment"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BottomNavBarPatient(switchTabIndex: 1))
                          );

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}