import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/chamber_model.dart';
import '../../../dialogs/dialog_booking_success.dart';
import '../../../dialogs/dialog_take_decision.dart';
import '../../../model/appointment_req_data.dart';
import '../../../model/dept_doctor.dart';
import '../../../services/appointment_req_service.dart';
import 'components/text_tile.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final String? speciality;
  final String? degree;
  final String? department;
  final String? drNo;
  final String? currentChember;
  final Doctor? drInfo;
  final int? aptFlag;
  const DoctorDetailsPage({
    Key? key,
    @required this.imageUrl,
    @required this.name,
    @required this.speciality,
    @required this.degree,
    @required this.department,
    @required this.drNo,
    @required this.currentChember,
    @required this.drInfo,
    @required this.aptFlag,
  }) : super(key: key);

  @override
  DoctorDetailsPageState createState() => DoctorDetailsPageState();
}

class DoctorDetailsPageState extends State<DoctorDetailsPage> {
  DoctorChamberModel chamberData = DoctorChamberModel();
  var isLoading = false;
  List<ShiftSlot> shiftSlots = [];
  bool isSlotFound = false;
  String selectedDate = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var shifts;
  @override
  Widget build(BuildContext context) {
    var drInfo2 = widget.drInfo;

    if (drInfo2 != null) {
      shifts = drInfo2.doctorShift;
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryColor, primaryColor.withOpacity(0.5)],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: widget.imageUrl == 'null' ? 45.0 : 30.0),
                        widget.imageUrl == 'null'
                            ? Image.asset(
                                defaultFemaleAssetImg,
                                height: 180,
                                fit: BoxFit.cover,
                              )
                            : ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl ?? '',
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/avatar.png",
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/avatar.png",
                                    height: 180,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF53cbf0),
                      border: Border.all(color: Colors.white60),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white70,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 218,
                  left: 20.0,
                  right: 20.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.name ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 8),
                                TextTile(
                                  title: widget.department,
                                  color: const Color(0xFF34dfb5),
                                ),
                                const SizedBox(width: 8),
                                TextTile(
                                  title: widget.speciality,
                                  color: const Color(0xFFf55a88),
                                ),
                                const SizedBox(width: 8),
                                TextTile(
                                  title: widget.degree ?? "...",
                                  color: const Color(0xFFfeab48),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: isLoading
                  ? Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        height: 100,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 16),
                          child: Center(
                            child: Text(
                              widget.aptFlag == 1
                                  ? "Schedule for Direct Appointment"
                                  : "Schedule for Online Appointment",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: widget.aptFlag == 1
                                    ? xcelSecColor
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: DropdownSearch<DoctorShift>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                            ),
                            items: shifts,
                            itemAsString: (DoctorShift? u) =>
                                u != null ? u.shiftAsString() : '',
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Appointment Date",
                                labelText: "Select Appointment Date",
                                helperText:
                                    'Please Select Appointment Date First',
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            onChanged: (DoctorShift? data) {
                              if (data != null) {
                                setState(() {
                                  var shiftSlot = data.shiftSlot;
                                  shiftSlots.clear();
                                  if (shiftSlot != null &&
                                      shiftSlot.isNotEmpty) {
                                    isSlotFound = true;
                                    selectedDate = data.shiftDt ?? '';
                                    shiftSlots.addAll(data.shiftSlot ?? []);
                                    debugPrint(
                                        "selectedDate------: $selectedDate");
                                  } else {
                                    selectedDate = '';
                                    isSlotFound = false;
                                  }
                                  debugPrint(
                                      "============${shiftSlot!.length}");
                                });
                                debugPrint(data.shiftDt);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            ),
            !isSlotFound
                ? Container()
                : SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: shiftSlots.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var shift = shiftSlots[index];
                        var timeSlot = shift.timeSlot;

                        return ScheduleTile(
                          dayNo: 'SL No: ${index + 1}',
                          schedule:
                              timeSlot, //'${chamberInfo.visitStart.toString()} - ${chamberInfo.visitEnd.toString()}',
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          onTapSlot: () {
                            debugPrint('Clicked lis....');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogTakeDecision(
                                      msgTitle: "Booking Alert",
                                      msgBody: "Do you want to book this slot?",
                                      positiveButtonText: "Book",
                                      negativeButtonText: "Cancel",
                                      callback: (isYesClick) async {
                                        debugPrint('====$isYesClick');
                                        var drInfo2 = widget.drInfo;
                                        if (isYesClick) {
                                          AppointmentReqData data =
                                              AppointmentReqData();
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          int? patId = prefs.getInt(prefUserId);
                                          debugPrint("patId: $patId");
                                          data.patientId = patId;
                                          data.appontDate = selectedDate;
                                          data.appontType =
                                              widget.aptFlag.toString();
                                          data.slotNumber =
                                              shift.shiftchdId.toString();
                                          data.startTime = shift.slotsTime;
                                          data.endTime = shift.sloteTime;
                                          data.deptNumber = drInfo2 != null
                                              ? drInfo2.deptN0.toString()
                                              : '';
                                          data.doctorNo = drInfo2 != null
                                              ? drInfo2.doctorNo
                                              : '';
                                          data.consultRoomNo = "";
                                          data.enteredBy = patId.toString();
                                          data.companyNo = "1";
                                          var fee = drInfo2 != null
                                              ? drInfo2.consultFee.toString()
                                              : '';
                                          data.serviceRate = double.parse(
                                              fee == 'null' || fee.isEmpty
                                                  ? "0.0"
                                                  : fee);
                                          setState(() {
                                            isLoading = true;
                                          });

                                          AppointmentRequestService()
                                              .sendRequest(data)
                                              .then((value) async {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            var msg =
                                                value["P_RETRNMSG0"].toString();

                                            debugPrint(msg);
                                            if (msg.contains("Successfully")) {
                                              setState(() {
                                                shiftSlots.removeAt(index);
                                              });
                                              await showDialog(
                                                context: _scaffoldKey
                                                    .currentContext!,
                                                builder: (context) {
                                                  return DialogBookingSuccess(
                                                      doctorName: drInfo2 !=
                                                              null
                                                          ? drInfo2.doctorName
                                                          : '',
                                                      consultationDate:
                                                          selectedDate,
                                                      status: "Pending",
                                                      consultationFee: fee);
                                                },
                                              );
                                            } else {
                                              CoolAlert.show(
                                                context: _scaffoldKey
                                                    .currentContext!,
                                                type: CoolAlertType.error,
                                                text: msg,
                                              );
                                            }
                                          });
                                        }
                                      });
                                });
                          },
                        );
                      },
                    )),
          ],
        ),
      ),
    );
  }
}
