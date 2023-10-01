import 'package:flutter/material.dart';

import '../../../../config/common_const.dart';

class TextTile extends StatelessWidget {
  final String? title;
  final Color? color;

  const TextTile({
    Key? key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$title',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleTile extends StatelessWidget {
  final String? dayNo;
  final String? schedule;
  final Color? color;
  final VoidCallback? onTapSlot;
  const ScheduleTile({
    Key? key,
    @required this.dayNo,
    @required this.schedule,
    @required this.color,
    @required this.onTapSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
          
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Text(
                    '$schedule',

                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('Clicked....');
                      onTapSlot!();
                    },
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
          ),
          
          Image.asset('assets/images/right_arrow_dotted.png',
              height: 30,)
        ],
      ),
    );
  }
}
