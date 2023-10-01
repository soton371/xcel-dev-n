import 'package:flutter/material.dart';

class NotPrepareScreen extends StatelessWidget {
  const NotPrepareScreen({super.key, required this.errorMsg});
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Patient"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            Image.asset("assets/images/add_patient.png",height: 80,width: 80,),
            //text
            Text("Not prepare to create patient\n$errorMsg", textAlign: TextAlign.center,style: const TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}