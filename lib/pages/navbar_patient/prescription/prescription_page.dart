import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/prescription/components/prescription_view.dart';
import 'package:xcel_medical_center/utils/date_time_utils.dart';

import '../../../model/apt_history.dart';
import '../../../services/apt_history_service.dart';
import '../home/components/drawer/drawer_menu.dart';
import 'components/prescription_list_tile.dart';

class PrescriptionListPage extends StatefulWidget {
  const PrescriptionListPage({super.key});

  @override
  State<StatefulWidget> createState()=> _PrescriptionListPage();
}

class _PrescriptionListPage extends State<PrescriptionListPage>{
  List<HistoryData> historyList = [];
  bool isLoading = true;

  @override
  void initState() {
    getHistory();
    super.initState();
  }


  Future<void> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

     Map body = {
      "P_PATIENTNO": prefs.getString(prefUserNo) // "P220100314"
    };

    AptHistoryService().getAppointmentHistory(body).then((value) {
      historyList.clear();
      // if(value != null){
        var hxList = value.pRETRNMSG1;
        if(hxList != null && hxList.isNotEmpty){
          historyList.addAll(hxList);
        }
      // }
      setState(() {
        isLoading = false;
      });
    });
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  void showSnack(String title) {
    final snackbar = SnackBar(
      backgroundColor: Colors.green,
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 15,
              backgroundColor: Colors.green,
              color: Colors.white
          ),
        ));
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Prescriptions'), systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        drawer: const DrawerMenu(),
        backgroundColor: kBackgroundColor,
        body: isLoading ? Center(child: Image.asset('assets/images/loader.gif', height: 100)) :
            ListView.builder(
            itemCount: historyList.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index){
              HistoryData data = historyList[index];
              return PrescriptionListTile(
                appointmentDate: "${DateTimeUtils().convertStringDateFormat(data.consultDt??'', DD_MMM_YYYY)} ${data.consultTime}",
                doctorName: data.doctorName == null || data.doctorName!.isEmpty ? "Dr ...." : data.doctorName,
                speciality: data.speciality == null || data.speciality!.isEmpty ? "....." : data.speciality,
                onTap: (){
                  debugPrint('Tap prescription $index');
                  showDialog(
                      context: context,
                      builder: (context) => PrescriptionView(data: data, listener: (isSuccess){
                        if(isSuccess){
                          getHistory();
                          showSnack('Successfully Sent Delivery Request!');
                        }
                      },)
                  );
                },
              );
            }
        ),
      ),
    );
  }
}