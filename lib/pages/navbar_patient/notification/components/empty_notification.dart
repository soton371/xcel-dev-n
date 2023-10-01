import 'package:flutter/material.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/notification.png",height: 80,width: 80,),
          const Text('\nThere are no notifications at this time',style: TextStyle(color: Colors.grey),)
        ],
      ),
    );
  }
}