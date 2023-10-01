import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/services/registration_service.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xcel_medical_center/widgets/show_snack.dart';

class ContactUsDialog extends StatefulWidget {
  const ContactUsDialog({
    Key? key,
  }) : super(key: key);

  @override
  ContactUsDialogState createState() => ContactUsDialogState();
}

class ContactUsDialogState extends State<ContactUsDialog> {
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
    String whatsapp =
        isLoading ? '' : callInfo['items'][0]['whatsapp'].toString();
    String phoneNo =
        isLoading ? '' : callInfo['items'][0]['contactno'].toString();
    String fbPath =
        isLoading ? '' : callInfo['items'][0]['ogcbu_info'].toString();
    String fb = "http://facebook.com/";
    String fbUrl = fb + fbPath;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: 288,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Center(
                  child: Text('Contact Us',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    height: 208,
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            CustomIconButton(
                              iconData: FontAwesomeIcons.phone,
                              btnBackgroundColor: Colors.grey.shade600,
                              btnSize: 24,
                              onBtnTap: () async {
                                debugPrint("phoneNo: $phoneNo");
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phoneNo,
                                );

                                if (!await launchUrl(launchUri)) {
                                  myToast(
                                    "Could not launch $phoneNo",
                                  );
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: InkWell(
                                  onTap: () async {
                                    debugPrint("phoneNo: $phoneNo");
                                    final Uri launchUri = Uri(
                                      scheme: 'tel',
                                      path: phoneNo,
                                    );

                                    if (!await launchUrl(launchUri)) {
                                      myToast("Could not launch $phoneNo",
                                      );
                                    }
                                  },
                                  child: Text(phoneNo,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[600]))),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomIconButton(
                              iconData: FontAwesomeIcons.whatsapp,
                              btnBackgroundColor: primaryColor,
                              onBtnTap: () async {
                                String whatsapp =
                                    callInfo['items'][0]['whatsapp'].toString();
                                String whatsappNumber = whatsapp.trim();
                                debugPrint(
                                    'whatsappNumber No: $whatsappNumber');

                                String message =
                                    "I want to create a patient account";

                                final uriUrl = Uri.parse(
                                    "https://wa.me/$whatsappNumber?text=$message");
                                try {
                                  if (!await launchUrl(uriUrl,
                                      mode: LaunchMode.externalApplication)) {
                                    myToast("Could not launch $whatsapp");
                                  }
                                } catch (e) {
                                  myToast("Could not launch $whatsapp");
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: InkWell(
                                  onTap: () async {
                                    String whatsapp = callInfo['items'][0]
                                            ['whatsapp']
                                        .toString();
                                    String whatsappNumber = whatsapp.trim();
                                    debugPrint(
                                        'whatsappNumber No: $whatsappNumber');

                                    String message =
                                        "I want to create a patient account";

                                    final uriUrl = Uri.parse(
                                        "https://wa.me/$whatsappNumber?text=$message");
                                    try {
                                      if (!await launchUrl(uriUrl,
                                          mode:
                                              LaunchMode.externalApplication)) {
                                        myToast("Could not launch $whatsapp");
                                      }
                                    } catch (e) {
                                      myToast("Could not launch $whatsapp");
                                    }
                                  },
                                  child: Text(whatsapp,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[600]))),
                            ),
                          ],
                        ),

                        //add for fb
                        Row(
                          children: [
                            CustomIconButton(
                              iconData: FontAwesomeIcons.facebookF,
                              btnBackgroundColor: Colors.blue.shade600,
                              btnSize: 24,
                              onBtnTap: () async {
                                Uri uriUrl = Uri.parse(fbUrl);
                                if (!await launchUrl(
                                  uriUrl,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  myToast("Could not launch $fbUrl");
                                }
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 200,
                              height: 40,
                              padding: const EdgeInsets.only(left: 32.0),
                              child: InkWell(
                                onTap: () async {
                                  Uri uriUrl = Uri.parse(fbUrl);
                                  if (!await launchUrl(
                                    uriUrl,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    myToast("Could not launch $fbUrl");
                                  }
                                },
                                child: Text(
                                  fbUrl,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
