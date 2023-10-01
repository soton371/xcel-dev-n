import 'dart:math';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class DoctorSpeciality extends StatelessWidget {
  final String? speciallityNo;
  final String? title;

  const DoctorSpeciality({super.key, 
    @required this.speciallityNo,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var dColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    String getImagePath() {
      String imagePath = '';
      if (speciallityNo == '1') {
        imagePath = 'assets/images/dr_category/cardiology.png';
      } else if (speciallityNo == '2') {
        imagePath = 'assets/images/dr_category/stethoscope.png';
      } else if (speciallityNo == '3') {
        imagePath = 'assets/images/dr_category/vascular.png';
      } else if (speciallityNo == '4') {
        imagePath = 'assets/images/dr_category/stethoscope.png';
      } else if (speciallityNo == '5') {
        imagePath = 'assets/images/dr_category/doctor-bag.png';
      } else if (speciallityNo == '104') {
        imagePath = 'assets/images/dr_category/tooth.png';
      } else if (speciallityNo == '7') {
        imagePath = 'assets/images/dr_category/surgery.png';
      } else if (speciallityNo == '8') {
        imagePath = 'assets/images/dr_category/sonography.png';
      } else if (speciallityNo == '9') {
        imagePath = 'assets/images/dr_category/neurology.png';
      } else if (speciallityNo == '10') {
        imagePath = 'assets/images/dr_category/doctor-bag.png';
      } else if (speciallityNo == '11') {
        imagePath = 'assets/images/dr_category/geriatric.png';
      } else if (speciallityNo == '100') {
        imagePath = 'assets/images/dr_category/pediatrics.png';
      } else if (speciallityNo == '102') {
        imagePath = 'assets/images/dr_category/gyn.png';
      } else if (speciallityNo == '14') {
        imagePath = 'assets/images/dr_category/ophthalmology.png';
      } else {
        imagePath = 'assets/images/ic_doctor.png';
      }
      return imagePath;
    }

    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 0,
              color: dColor.shade300,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  getImagePath(),
                  height: 60,
                  width: 60,
                  color: kBackgroundColor,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: 125,
              padding: const EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
              child: Text(
                title??'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: dColor,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
