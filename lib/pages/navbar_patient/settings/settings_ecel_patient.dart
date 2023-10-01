import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/pages/navbar_patient/edit_profile/edit_profile_scr.dart';
import 'package:xcel_medical_center/widgets/setting_listtile.dart';
import 'package:xcel_medical_center/widgets/show_snack.dart';
import '../../../dialogs/dialog_change_password.dart';
import '../home/components/drawer/drawer_menu.dart';

class SettingsEcelPatient extends StatefulWidget {
  const SettingsEcelPatient({super.key});

  @override
  SettingsEcelPatientState createState() => SettingsEcelPatientState();
}

class SettingsEcelPatientState extends State<SettingsEcelPatient> {
  @override
  Widget build(BuildContext context) {
    final appBAr = AppBar(
      title: const Text(
        "Setting",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 19),
      ),
    );
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          appBar: appBAr,
          drawer: const DrawerMenu(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                settingListTile(context,
                    title: "Change Password",
                    leadingColor: CupertinoColors.systemYellow,
                    icon: CupertinoIcons.lock_fill, onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialogChangePassword(
                          listener: (isSuccess) {
                            showSnack('Successfully Password Changed');
                            debugPrint("pass****************************");
                          },
                        );
                      });
                }),
                settingListTile(context,
                    title: "Edit Profile",
                    leadingColor: CupertinoColors.activeGreen,
                    icon: CupertinoIcons.pencil, onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                })
              ],
            ),
          )),
    );
  }
}
