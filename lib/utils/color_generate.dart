import 'package:flutter/material.dart';

Color colorGenerate(BuildContext context, int status){
  if (status == 0) {
    return Colors.amber;
  } else if (status == 1) {
    return const Color(0xff039487);
  } else if (status == 2) {
    return Colors.redAccent;
  } else if (status == 3) {
    return Theme.of(context).colorScheme.primary;
  }else{
    return Theme.of(context).colorScheme.primary;
  }
}

bool showAction(int status){
  if (status == 3) {
    return true;
  } else {
    return false;
  }
}

bool cardEnable(int status){
  if (status == 3 || status == 0) {
    return true;
  } else {
    return false;
  }
}