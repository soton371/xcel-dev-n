

import 'package:flutter/material.dart';

import '../config/common_const.dart';
import '../model/apt_history.dart';
import '../pages/navbar_patient/doctors/components/appointment/dialog_text_tile.dart';
import '../services/apt_history_service.dart';

class DialogMedicineReq extends StatefulWidget{

  final String? doctorName;
  final String? doctorDesignation;
  final List<PatMedicine>? medicineList;
  final HistoryData? data;
  final ReqCallback? callback;

  const DialogMedicineReq({Key? key, this.doctorName, this.doctorDesignation, this.medicineList, this.data, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DialogMedicineReq();

}

typedef ReqCallback = void Function(bool isYesClick);
// typedef void ReqCallback(bool isYesClick);

class _DialogMedicineReq extends State<DialogMedicineReq>{
  bool isLoading = false;
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: const Center(
                child: Text(
                  'Medicine Delivery Request',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                    // DialogTextTile(title: 'Patient Name         : ', value: patientName, titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Doctor Name : ', value: widget.doctorName ?? '', titleColor: Colors.green, valueColor: Colors.black),
                    DialogTextTile(title: 'Designation   : ', value: widget.doctorDesignation ?? '', titleColor: Colors.green, valueColor: Colors.black),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Table(
                  // defaultColumnWidth: FixedColumnWidth(width * 0.5 - 40),
                    border: TableBorder.all(color: primaryColor, width: 2),
                    columnWidths: const {
                      0: FlexColumnWidth(3.0),
                      1: FlexColumnWidth(1.0),
                    },
                    children: getPrescriptionTableRow(widget.medicineList ?? [])
                ),
              ),
            ),

            isLoading ? Center(child: Image.asset('assets/images/loader.gif', height: 100)) : Container(),
            const SizedBox(height: 15),
            Center(child: Text(errorMsg, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });

                var data = widget.data;
                Map<String, String> body = {};
                if (data != null) {
                  body = {
                  "P_CONSULTNO" : data.consultNo ?? ''
                };
                }

                
                AptHistoryService().sendMedicineDeliveryReq(body).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  if(value.isNotEmpty){
                    var status = value["P_RETRNMSGN"];
                    if("200" == status && widget.callback != null){
                      widget.callback!(true);
                      Navigator.of(context).pop();
                    }else{
                      setState(() {
                        errorMsg = "Request send failed";
                      });
                    }
                  }else{
                    setState(() {
                      errorMsg = "Unable to send request";
                    });
                  }
                });
              },
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
              child: Text('Send Request Now',style: TextStyle(color: primaryColor)),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

List<TableRow> getPrescriptionTableRow(List<PatMedicine> medicinList) {
  List<TableRow> childs = [];
  if(medicinList.isNotEmpty){

    // FIRST ROW ADDED IN "childs" LIST
    childs.add(
      const TableRow(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('Prescribed Items', textAlign: TextAlign.center),
          ),
        ],
      ),
    );

    // MIDDLE ROW ADDED IN "childs" LIST
    double total = 0;

    for(var m in medicinList){
      double price = m.price ?? 0.0;
      total = total + price;
      childs.add(
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 16, 0, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.medicineName ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                        RichText(
                          text: TextSpan(
                            text: 'Frequency: ',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: m.freequency, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'Duration: ',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: m.duration, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'M. Of Admin: ',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: m.useMathod, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ]),
                ),

              ]));
    }


    // LAST ROW ADDED IN "childs" LIST
    childs.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('Total Medicine: ${medicinList.length}', textAlign: TextAlign.center),
          ),

        ],
      ),
    );
  }

  return childs;
}