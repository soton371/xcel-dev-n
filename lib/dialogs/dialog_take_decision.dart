import 'package:flutter/material.dart';

class DialogTakeDecision extends StatefulWidget {
  final String? msgTitle;
  final String? msgBody;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final DecisionCallback? callback;

  const DialogTakeDecision({
    Key? key,
    this.msgTitle,
    this.msgBody,
    this.positiveButtonText,
    this.negativeButtonText,
    this.callback,
  }) : super(key: key);

  @override
  _DialogTakeDecision createState() => _DialogTakeDecision();
}

typedef DecisionCallback = void Function(bool isYesClick);
// typedef void DecisionCallback(bool isYesClick);

class _DialogTakeDecision extends State<DialogTakeDecision> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(widget.msgTitle ?? ''),
      content: Text(
        widget.msgBody ?? '',
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (widget.callback != null) {
                widget.callback!(false);
              }

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              widget.negativeButtonText ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        const SizedBox(width: 5),
        ElevatedButton(
          child: Text(widget.positiveButtonText ?? ''),
          onPressed: () {
            if (widget.callback != null) {
              widget.callback!(true);
            }

            Navigator.pop(context);
          },
        ),
      ],
    );
    
  }
}
