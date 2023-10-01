import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/config/sp_utils.dart';
import 'package:xcel_medical_center/model/chamber_model.dart';
import 'package:xcel_medical_center/model/doctor_category_model.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/appointment/dialog/booking_req_success_dialog.dart';

class BookingDecisionDialog extends StatefulWidget {
  final String? drName, schedule, imageUrl, appointmentDate, consultationFee;
  final int? consultType;
  final DoctorList? drInfo;
  final DoctorChamberModel? chamberInfo;

  const BookingDecisionDialog({
    Key? key,
    @required this.drName,
    @required this.schedule,
    @required this.imageUrl,
    @required this.consultType,
    @required this.drInfo,
    @required this.chamberInfo,
    @required this.appointmentDate,
    @required this.consultationFee,
  }) : super(key: key);

  @override
  BookingDecisionDialogState createState() => BookingDecisionDialogState();
}

class BookingDecisionDialogState extends State<BookingDecisionDialog> {
  Map loginResp = {};
  bool isLoading = false;
  String patientName = '';
  String patientNo = '';
  Future getRespFromSP() async {
    var resp = await SharedPref().getPatientLoginResp();
    setState(() {
      loginResp = jsonDecode(resp);
    });
  }

  @override
  Widget build(BuildContext context) {
    patientName =
        isLoading ? '' : loginResp['listResponse'][0]['patientName'].toString();
    patientNo =
        isLoading ? '' : loginResp['listResponse'][0]['patientNo'].toString();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.drName ?? '',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                widget.schedule ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  // color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Patient Name: $patientName',
                style: const TextStyle(
                  fontSize: 14,
                  // color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure to book appointment?',
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                child: CircularProgressIndicator()));
                      },
                      child: const Text("  Book  ",
                          style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            var drInfo3 = widget.drInfo;
                            return BookingReqSuccessDialog(
                              doctorName: drInfo3 != null
                                  ? drInfo3.doctorName ?? ''
                                  : '',
                              patientName: patientName,
                              consultationDate: widget.appointmentDate ?? '',
                              status: 'Not Paid',
                              consultationFee: widget.consultationFee ?? '',
                            );
                          },
                        );
                      },
                      child:
                          const Text("Cancel", style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: widget.imageUrl == 'null'
                ? ClipOval(
                    child: Image.asset(
                      defaultFemaleAssetImg,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl ?? '',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        "assets/images/avatar.png",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/avatar.png",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                  ),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
