import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/utils/date_time_utils.dart';
import '../../../model/investigation.dart';
import '../../../services/investigation_service.dart';
import '../home/components/drawer/drawer_menu.dart';
import 'components/request_tile.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key }) : super(key: key);

  @override
  RequestPageState createState() => RequestPageState();
}

class RequestPageState extends State<RequestPage> {

  bool isLoading = true;
  List<ConsultInfo> invstConsultInfoList = [];

  @override
  void initState() {
    getInvestigationsData();
    super.initState();
  }

  Future<void> getInvestigationsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map body = {
      "P_PATIENTNO":  prefs.getString(prefUserNo)//"P220100311"
    };
    InvestigationService().getInvestigations(body).then((value) {
      invstConsultInfoList.clear();
      var consultInfoList = value.consultInfo;
      if(consultInfoList != null && consultInfoList.isNotEmpty){
        invstConsultInfoList.addAll(consultInfoList);
      }

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
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          // backgroundColor: primaryColor,
          title: const Text('Requested Investigations'), systemOverlayStyle: SystemUiOverlayStyle.dark,

        ),
        drawer: const DrawerMenu(),
        body: isLoading ? Center(
          child: Image.asset(
            'assets/images/loader.gif',
            height: 100,
          ),
        ) : ListView.builder(
          itemCount: invstConsultInfoList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          itemBuilder: (context, index){
            var info = invstConsultInfoList[index];
            List<Investigations> investigations = info.investigations ?? [];
            return RequestTile(
              doctorName: info.doctorName ?? "",
              speciality: info.speciality ?? "",
              appointmentDate: "${DateTimeUtils().convertStringDateFormat(info.consultDt??'', DD_MMM_YYYY)} ${info.consultTime??''}",
              investigations: investigations,
              listener: (isSuccess){
                if(isSuccess){
                  showSnack("Upload Successful");
                  getInvestigationsData();
                }
              },
            );
          }),
      ),
    );
  }
}

