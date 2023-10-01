import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class CustomListTile extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Function()? onTap;

  const CustomListTile({super.key, @required this.icon, @required this.text, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: cViolet.withOpacity(0.1)),
          ),
        ),
        child: InkWell(
          //splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: SizedBox(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      // color: primaryColor,
                      color: Colors.blueGrey,
                      size: 26,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(
                      text??'',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
