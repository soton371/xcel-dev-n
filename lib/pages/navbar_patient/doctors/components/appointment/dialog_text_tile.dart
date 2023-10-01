import 'package:flutter/material.dart';

class DialogTextTile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? titleColor;
  final Color? valueColor;
  const DialogTextTile({
    Key? key,
    @required this.title,
    @required this.value,
    @required this.titleColor,
    @required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(fontWeight: FontWeight.bold, color: titleColor, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.bold, color: valueColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}