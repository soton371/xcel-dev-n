import 'package:flutter/material.dart';

void myAlertDialog(BuildContext context, {String? titleMsg, String? contentMsg, List<Widget>? actions}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Text(titleMsg ?? ''),
      content: Text(contentMsg ?? ''),
      actions: actions,
    ),
  );
}
