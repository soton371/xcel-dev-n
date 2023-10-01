import 'package:flutter/material.dart';
import 'package:xcel_medical_center/animation/splash_animation/animation_screen.dart';
import 'package:xcel_medical_center/pages/login/decision_login_page.dart';
import 'package:xcel_medical_center/pages/navbar_patient/bottom_navbar_patient.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
    @required this.email,
    @required this.saveUser,
  }) : super(key: key);
  final String? email;
  final String? saveUser;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          (saveUser.toString() == 'null' ||
                  email.toString() == 'null' ||
                  saveUser == '' ||
                  email == '')
              ? const DecisionLogin()
              : const BottomNavBarPatient(),
          const IgnorePointer(
            child: AnimationScreen(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
