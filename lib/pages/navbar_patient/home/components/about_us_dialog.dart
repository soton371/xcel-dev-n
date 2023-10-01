import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class AboutUsDialog extends StatefulWidget {
  const AboutUsDialog({
    Key? key,
  }) : super(key: key);

  @override
  AboutUsDialogState createState() => AboutUsDialogState();
}

class AboutUsDialogState extends State<AboutUsDialog> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    return AlertDialog(
      title: const Text("About US"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Xcel Medical Centre!",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'About Xcel medical centre',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Xcel medical centre formerly (El Well clinic) was established in December 2018. The focus of the Centre is to offer (E)XCELLENT medical services to both local and international clients,just as our name depicts, with the help of Almighty God and our very well qualified and capable staff members. ',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'MISSION',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Our mission is to inculcate in the minds of our cherished clients the need to TAKE CONTROL OF THEIR STATE OF HEALTH through routine health checks, create various health educational platforms ,easy , affordable ,quality and excellent wide range of specialists. For us client satisfaction is our highest priority and non negotiable.',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'VISION',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Our vision is to contribute immensely and constantly towards a healthier humanity and to be a reference centre when it comes to health related services. Our professional, human centred activities reflects what we stand for. We strive to (E)Xcel.',
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
      ],
    );
  }
}