import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/chamber_model.dart';
import 'package:xcel_medical_center/model/doctor_category_model.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/schedule_dropdown.dart';
import 'package:intl/intl.dart';
import 'booking_tile.dart';
import 'dialog/booking_decision_dialog.dart';

class AppointmentTile extends StatefulWidget {
  final DoctorChamberModel? chamberData;
  final String? imageUrl;
  final String? drName;
  final DoctorList? drInfo;
  const AppointmentTile({
    Key? key,
    @required this.chamberData,
    @required this.imageUrl,
    @required this.drName,
    @required this.drInfo,
  }) : super(key: key);

  @override
  AppointmentTileState createState() => AppointmentTileState();
}

class AppointmentTileState extends State<AppointmentTile> {
  String schedule = 'select schedule';
  String timeSlot = '';
  List<int> sanitizeDate(DoctorChamberModel chamberData) {
    List<int> dayValue = [];
    List<int> dayIndex = [];
    var objResponse2 = chamberData.objResponse;
    if (objResponse2 != null) {
      dayValue.add(objResponse2.sun ?? 0);
    dayValue.add(objResponse2.mon??0);
    dayValue.add(objResponse2.tue??0);
    dayValue.add(objResponse2.wed??0);
    dayValue.add(objResponse2.thu??0);
    dayValue.add(objResponse2.fri??0);
    dayValue.add(objResponse2.sat??0);
    }
    
    debugPrint("dayValue: ${dayValue.map((e) => e)}");
    for (int i = 0; i < dayValue.length; i++) {
      if (dayValue[i] == 0) {
        int cIndx = i == 0 ? 7 : i;
        dayIndex.add(cIndx);
      }
    }
    debugPrint("dayIndex: $dayIndex");
    return dayIndex;
  }

  ObjResponse? obj3;
  List<DrConsultFeeList>? drConsultFeeList3;
  

  @override
  Widget build(BuildContext context) {
    var chamberData3 = widget.chamberData;
    if (chamberData3 != null) {
      obj3 = chamberData3.objResponse;
      if(obj3 != null){
        drConsultFeeList3 = obj3!.drConsultFeeList;
      }
      
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Appointment Date',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  var chamberData2 = widget.chamberData;
                  if (chamberData2 != null) {
                    List<int> filteredList = sanitizeDate(chamberData2);
                    DateTime startDate = DateTime.now().add(const Duration(days: 1));
                    showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: startDate,
                      lastDate: DateTime(2025, 12),
                      selectableDayPredicate: (DateTime val) {
                        for (int i = 0; i < filteredList.length; i++) {
                          if (val.weekday == filteredList[i]) return false;
                        }
                        return true;
                      }).then((pickedDate) {
                    // String formattedDate = DateFormat.yMMMMEEEEd().format(pickedDate).toString();
                    var dateFormat = DateFormat('EEEE, dd-MMM-yyyy');
                    String formattedDate = dateFormat.format(pickedDate ?? DateTime.now());
                    setState(() {
                      schedule = formattedDate.toString();
                    });
                  });
                  }
                  
                  
                  
                },
              )
            ],
          ),
          ScheduleDropdown(
            onValueChanged: (time){
              setState(() {
                timeSlot = time;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: cViolet),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      schedule,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: schedule == "select schedule" ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (drConsultFeeList3??[]).length,
                        itemBuilder: (context, index) {
                          var bookingInfo = (drConsultFeeList3??[])[index];
                          return BookingTile(
                            consultType: bookingInfo.consultType.toString(),
                            consultFee: bookingInfo.consultFee.toString(),
                            onTapBtn: () {
                              (schedule == "select schedule" || timeSlot == '')
                              ? Fluttertoast.showToast(
                                msg: "Please select your appointment date and time!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              )
                              : showDialog(
                                context: context,
                                builder: (context) {
                                  return BookingDecisionDialog(
                                    imageUrl: widget.imageUrl,
                                    drName: widget.drName,
                                    schedule: schedule,
                                    drInfo: widget.drInfo,
                                    chamberInfo: widget.chamberData,
                                    consultType: bookingInfo.consultType,
                                    appointmentDate: schedule,
                                    consultationFee: bookingInfo.consultFee.toString(),
                                  );
                              });
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
