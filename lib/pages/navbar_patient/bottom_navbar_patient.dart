import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';
import 'package:xcel_medical_center/pages/navbar_patient/appointments/appointment_page.dart';
import 'package:xcel_medical_center/pages/navbar_patient/prescription/prescription_page.dart';
import 'package:xcel_medical_center/pages/navbar_patient/requests/request_page.dart';
import 'home/home_page.dart';
import 'settings/settings_ecel_patient.dart';

class BottomNavBarPatient extends StatefulWidget {
  final int switchTabIndex, appointmentTabIndex;
  const BottomNavBarPatient(
      {super.key, this.switchTabIndex = 0, this.appointmentTabIndex = 1});

  @override
  BottomNavBarPatientState createState() => BottomNavBarPatientState();
}

class BottomNavBarPatientState extends State<BottomNavBarPatient> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.switchTabIndex;
  }

  List<Widget> getPages() {
    List<Widget> pages = [
      const HomePage(),
      AppointmentPage(initialIndex: widget.appointmentTabIndex),
      const RequestPage(),
      const PrescriptionListPage(),
      const SettingsEcelPatient(),
    ];
    return pages;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: getPages()[currentIndex],
        ),
        bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: currentIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Home',
              selectedIcon: CupertinoIcons.house_fill,
              unselectedIcon: CupertinoIcons.house,
              selectedBackgroundColor:
                  Colors.deepPurpleAccent[200] ?? Colors.deepPurpleAccent,
              unselectedBackgroundColor:
                  Colors.deepPurpleAccent[100] ?? Colors.deepPurpleAccent,
            ),
            FlipBoxNavigationBarItem(
              name: 'Appointment',
              selectedIcon: CupertinoIcons.calendar_today,
              unselectedIcon: CupertinoIcons.calendar,
              selectedBackgroundColor:
                  Colors.greenAccent[200] ?? Colors.greenAccent,
              unselectedBackgroundColor:
                  Colors.greenAccent[100] ?? Colors.greenAccent,
            ),
            FlipBoxNavigationBarItem(
              name: 'Requests',
              selectedIcon: Icons.assignment,
              unselectedIcon: Icons.assessment_outlined,
              selectedBackgroundColor:
                  Colors.redAccent[200] ?? Colors.redAccent,
              unselectedBackgroundColor:
                  Colors.redAccent[100] ?? Colors.redAccent,
            ),
            FlipBoxNavigationBarItem(
              name: 'Prescription',
              selectedIcon: CupertinoIcons.time_solid,
              unselectedIcon: CupertinoIcons.time,
              selectedBackgroundColor:
                  Colors.orangeAccent[200] ?? Colors.orangeAccent,
              unselectedBackgroundColor:
                  Colors.orangeAccent[100] ?? Colors.orangeAccent,
            ),
            FlipBoxNavigationBarItem(
              name: 'Settings',
              selectedIcon: CupertinoIcons.settings_solid,
              unselectedIcon: CupertinoIcons.settings,
              selectedBackgroundColor: Colors.blueGrey[200] ?? Colors.blueGrey,
              unselectedBackgroundColor:
                  Colors.blueGrey[100] ?? Colors.blueGrey,
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            debugPrint("currentIndex: $currentIndex");
          },
        ));
  }
}
