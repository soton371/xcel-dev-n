import 'package:flutter/material.dart';

class DecisionCard extends StatelessWidget {
  const DecisionCard({
    Key? key,
    @required this.title,
    this.fontSize = 24.0,
    @required this.imagePath,
    @required this.onTap,
  }) : super(key: key);

  final String? title;
  final double fontSize;
  final String? imagePath;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.72,
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 9.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imagePath??'',
                  height: 30,
                  width: 30,
                ),
                Flexible(
                  child: Text(
                    title??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
