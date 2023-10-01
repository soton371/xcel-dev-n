import 'package:flutter/material.dart';
import 'package:xcel_medical_center/pages/navbar_patient/appointments/tabs/pay_page.dart';
import 'package:xcel_medical_center/pages/navbar_patient/appointments/tabs/upcoming_page.dart';

import '../home/components/drawer/drawer_menu.dart';

class AppointmentPage extends StatelessWidget {
  final int initialIndex;
  const AppointmentPage({Key? key, this.initialIndex = 1 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: initialIndex,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Xcel Medical Centre'),
            toolbarHeight: 56,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Pay'),
              ],
            ), 
          ),
          drawer: const DrawerMenu(),
          body: const TabBarView(
            children: [
              UpcomingPage(),
              PayPage(),
            ],
          ),
        ),
      );
  }
}