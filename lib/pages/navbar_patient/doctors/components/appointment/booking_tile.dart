import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

import '../text_tile.dart';

class BookingTile extends StatelessWidget {
  final String? consultType;
  final String? consultFee;
  final VoidCallback? onTapBtn;

  const BookingTile({
    Key? key,
    @required this.consultType,
    @required this.consultFee,
    @required this.onTapBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String consultTypeInfo = consultType == '1'
        ? 'Primary     '
        : consultType == '2'
            ? 'Followup   '
            : 'Report       ';
    String? consultFeeInfo = consultFee == '0.0' ? 'Free' : consultFee;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$consultTypeInfo: $consultFeeInfo',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          InkWell(
            onTap: () => onTapBtn!(),
            child: TextTile(
              title: '    Book    ',
              color: cViolet,
            ),
          ),
        ],
      ),
    );
  }
}
