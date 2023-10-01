import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/services/registration_service.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationDialog extends StatefulWidget {
  const RegistrationDialog({
    Key? key,
  }) : super(key: key);

  @override
  RegistrationDialogState createState() => RegistrationDialogState();
}

class RegistrationDialogState extends State<RegistrationDialog> {
  var callInfo;
  bool isLoading = true;

  @override
  void initState() {
    RegistrationService().fetchCallInfo().then((value) {
      setState(() {
        callInfo = value;
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: const Center(child: Text('Registration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Column(
                  children: [
                    Text('Contact Us To Complete ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey)),
                    Text('Your Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            isLoading ? const Center(child: CircularProgressIndicator()) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  iconData: FontAwesomeIcons.whatsapp,
                  btnBackgroundColor: primaryColor,
                  onBtnTap: () async {
                    String whatsapp = callInfo['items'][0]['whatsapp'].toString();
                    debugPrint('Whatsapp No: $whatsapp');
                    String whatsappNumber = whatsapp.replaceAll(' ', '');
                    debugPrint('whatsappNumber No: $whatsappNumber');

                    String message = "I want to create a patient account";
                    String url;
                    Uri uriUrl;
                    if (Platform.isIOS) {
                      url = "whatsapp://wa.me/$whatsappNumber/?text=${Uri.encodeFull(message)}";
                      uriUrl = Uri.parse(url);
                    } else {
                      url = "whatsapp://send?phone=$whatsapp&text=${Uri.encodeFull(message)}";
                      uriUrl = Uri.parse(url);
                    }


                    try {
                      if (!await launchUrl(
                        uriUrl,
                      )) {
                        Fluttertoast.showToast(
                          msg: "Could not launch $whatsapp",
                        );
                      }
                    }catch(e){
                      Fluttertoast.showToast(
                        msg: "Could not launch $whatsapp",
                      );
                    }

                  },
                ),
                const SizedBox(width: 40),
                CustomIconButton(
                  iconData: FontAwesomeIcons.phone,
                  btnBackgroundColor: Colors.grey[600] ?? Colors.grey,
                  btnSize: 24,
                  onBtnTap: () async {
                    String phoneNo = callInfo['items'][0]['contactno'].toString();
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: phoneNo,
                    );

                    if(!await launchUrl(launchUri)){
                      Fluttertoast.showToast(
                        msg: "Could not launch $phoneNo",
                      );
                    }

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
