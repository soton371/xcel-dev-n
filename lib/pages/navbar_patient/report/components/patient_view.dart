import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/widgets/timeline_widget.dart';

class PatientView extends StatefulWidget {
  final String? patientName;
  final String? reqNo;
  // final String gender;
  final String? visitDate;
  final String? totalReport;
  final String? referredBy;
  final String? pendingReport;
  final String? collectedSample;
  final String? totalInstruction;
  final String? totalSample;
  final String? consultationNo;
  final String? admissionNo;
  final int? index;
  final int? listLength;

  const PatientView({super.key, 
    @required this.patientName,
    @required this.reqNo,
    // @required this.gender,
    @required this.visitDate,
    @required this.totalReport,
    @required this.referredBy,
    @required this.pendingReport,
    @required this.collectedSample,
    @required this.totalInstruction,
    @required this.totalSample,
    @required this.consultationNo,
    @required this.admissionNo,
    @required this.index,
    @required this.listLength,
  });

  @override
  PatientViewState createState() => PatientViewState();
}

class PatientViewState extends State<PatientView> {
  String formattedDate(String visitDate) {
    String formatDate;
    String day = visitDate.substring(0, 2);
    String month = visitDate.substring(3, 6);
    String year = visitDate.substring(7, 11);
    formatDate = '${day}th $month, $year';
    return formatDate;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(width: 5.0),
            Column(
              children: [
                CustomTimeLineDate(
                  lineHeight: 75,
                  text: widget.visitDate == ''
                      ? ''
                      : formattedDate(widget.visitDate??''),
                  lineColor: cViolet,
                  circleBorderColor: cViolet,
                ),
                (widget.index??0) + 1 == widget.listLength
                    ? CustomTimeLineEnd(
                        lineHeight: 0,
                        lineColor: cViolet,
                        text: 'End',
                      )
                    : Container(),
              ],
            ),
            
            Container(
              padding: const EdgeInsets.only(left: 4, right: 5, top: 10),
              height: 200,
              width: width - 58,
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 9.0, top: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.referredBy == 'n/a'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Referred By         : ',
                                        style: TextStyle(
                                          letterSpacing: 0.1,
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                (widget.referredBy??'').toUpperCase(),
                                            style: TextStyle(
                                                color: textBlack,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ]),
                                  ),
                                ),
                          widget.consultationNo == ''
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Consultation No : ',
                                        style: TextStyle(
                                          letterSpacing: 0.1,
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: (widget.consultationNo??'')
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: textBlack,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ]),
                                  ),
                                ),
                          
                          widget.reqNo == ''
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Lab Request No  : ',
                                        style: TextStyle(
                                          letterSpacing: 0.1,
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: widget.reqNo,
                                            style: TextStyle(
                                                color: textBlack,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ]),
                                  ),
                                ),
                          widget.totalSample == 'null'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'No of Total Sample         : ',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: cYellow,
                                          shape: BoxShape.circle,
                                          // borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (widget.totalSample??''),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          widget.collectedSample == 'null'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'No of Collected Sample : ',
                                        style: TextStyle(
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: cViolet,
                                          shape: BoxShape.circle,
                                          // borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (widget.collectedSample??''),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          widget.totalInstruction == 'null'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Instruction for Patient    : ',
                                        style: TextStyle(
                                          color: textBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          // borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (widget.totalInstruction??''),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      (widget.pendingReport == 'null' ||
                              widget.pendingReport == '0')
                          ? Container()
                          : Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                    // borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (widget.pendingReport??''),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 15,
          top: (widget.index??0) + 1 == widget.listLength ? 2 : -11,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 55,
            width: 150,
            child: Card(
              color: cViolet,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  widget.totalReport == 'null'
                      ? 'Total Report : 0'
                      : "Total Report : ${widget.totalReport}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
