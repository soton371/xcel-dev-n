import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/appointments/components/upcoming_tile.dart';

import '../../../../model/appointment.dart';
import '../../../../services/upcoming_apt_service.dart';
import '../../../../utils/date_time_utils.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key }) : super(key: key);

  @override
  UpcomingPageState createState() => UpcomingPageState();
}

class UpcomingPageState extends State<UpcomingPage> {

  bool isLoading = true;
  List<AppointmentData> aptList = [];
  String? patName = "";
  String? patEmail = "";

  @override
  void initState() {
    super.initState();
    getUpcomingAptData();
  }

  Future<void> getUpcomingAptData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     patName = prefs.getString(prefPatientName);
     patEmail = prefs.getString(prefPatientEmail);
    Map body = {
      "P_PATIENTNO": prefs.getString(prefUserNo)
    };
    UpcomingAptService().getUpcomingAppointment(body).then((value) {
      var appointmentsList = value.pRETRNMSG1;
      if(appointmentsList != null && appointmentsList.isNotEmpty){
        aptList.addAll(appointmentsList);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: isLoading ? Center(
        child: Image.asset(
          'assets/images/loader.gif',
          height: 100,
        ),
      ) : aptList.isEmpty? const Center(child: Text("There are currently no appointments available")):
      ListView.builder(
        itemCount: aptList.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index){
          AppointmentData data = aptList[index];
          String doctorName = data.doctorName ?? "";
          return UpcomingTile(
            appointmentDate: "${DateTimeUtils().convertStringDateFormat(data.consultDt??'', EEE_DD_MMM_YYYY)} ${data.consultTime}",
            doctorName: doctorName,
            drSpeciality: data.speciality ?? "",
            serialNo: data.slNo ?? "",
            consultTypeNo: data.consultTypeNo,
            onTapVideo: (){
              joinJistiWraperMeeting(data.jitsiRoomNo ?? "", doctorName);
            },
          );
        }
      ),
    );
  }

  joinJistiWraperMeeting(String meetingRoomNo, String doctorName) async{

    Map<FeatureFlag, Object> featureFlag = {};
    // Map<FeatureFlag, Object> featureFlag = new HashMap();
    featureFlag[FeatureFlag.isWelcomePageEnabled] = false;
    featureFlag[FeatureFlag.resolution ] = FeatureFlagVideoResolution.MD_RESOLUTION;

    var options = JitsiMeetingOptions(
        roomNameOrUrl: meetingRoomNo,
       // serverUrl: "https://atilimited.net/",
        subject: "Consultation with $doctorName",
        userDisplayName: patName,
        userEmail: patEmail,
        userAvatarUrl: "https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg",
        isAudioOnly: false,
        isAudioMuted: false,
        isVideoMuted: false,
        featureFlags: featureFlag);

    await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(
          onConferenceWillJoin: (url) => debugPrint("onConferenceWillJoin: url: $url"),
          onConferenceJoined: (url) => debugPrint("onConferenceJoined: url: $url"),
          onConferenceTerminated: (url, error) => debugPrint("onConferenceTerminated: url: $url, error: $error"),
          onAudioMutedChanged: (isMuted) => debugPrint("onAudioMutedChanged:- Audio muted $isMuted"),
          onChatMessageReceived: (senderId, message, isPrivate) => debugPrint("onChatMessageReceived:- senderId: $senderId, message: $message, isPrivate: $isPrivate"),
          onChatToggled: (isOpen) => debugPrint("onChatToggled: $isOpen"),
          onClosed: () => debugPrint("onClosed:- meeting close"),
          onOpened: () => debugPrint("onOpened:- onOpened"),
          onParticipantJoined: (email, name, role, participantId,) => debugPrint("onParticipantJoined email: $email, name: $name, role: $role, $participantId"),
          onParticipantLeft: (participantId) => debugPrint("onParticipantLeft:- participantId: $participantId"),
          onParticipantsInfoRetrieved: (participantsInfo, requestId) => debugPrint("onParticipantsInfoRetrieved:- participantsInfo List: $participantsInfo, requestId: $requestId" ),
          onScreenShareToggled: (participantId, isSharing) => debugPrint("onScreenShareToggled:- participantId: $participantId, isSharing: $isSharing"),
          onVideoMutedChanged: (isMuted) => debugPrint("onVideoMutedChanged:- isMuted: $isMuted")
      ),
    );
  }

}

class FeatureFlagVideoResolution {
  static const LD_RESOLUTION = 180;

  static const MD_RESOLUTION = 360;

  static const SD_RESOLUTION = 480;

  static const HD_RESOLUTION = 720;
}