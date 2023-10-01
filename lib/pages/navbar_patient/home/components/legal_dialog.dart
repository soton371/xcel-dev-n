import 'package:flutter/material.dart';

class LegalDialog extends StatefulWidget {
  const LegalDialog({
    Key? key,
  }) : super(key: key);

  @override
  LegalDialogState createState() => LegalDialogState();
}

class LegalDialogState extends State<LegalDialog> {
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
      title: const Text("Terms and Conditions"),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Xcel Medical Centre! \n\nThese terms and conditions outline the rules and regulations for the use of Xcel Medical Centre. \n\nBy accessing this App we assume you accept these terms and conditions.",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Information collected through our App',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'We collect information regarding your geolocation, mobile App, when you use our App. We may also collect information about the phone network associted with your mobile device, your mobile device operating system or platform, the type of mobile device you use and the features of our App you accessed. This information is primarly needed to maintain the security and operation of our App, for troubleshooting, internal analytics and reporting purposes.',
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