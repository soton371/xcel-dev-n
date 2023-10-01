import 'package:flutter/material.dart';

class EmptyRequest extends StatelessWidget {
  const EmptyRequest({super.key,required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('assets/images/request.png',height: 80,width: 80,),
        const SizedBox(height: 10,),
        Text(message,style: const TextStyle(color: Colors.black54,fontSize: 16),)]),
    );
  }
}