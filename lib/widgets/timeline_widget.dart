import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  final double? height;
  final Color lineColor;
  final Color circleColor;
  final bool enableImage;
  final String imageUrl;
  final bool isImageFromApi;
  const CustomTimeLine({super.key, 
    @required this.height,
    this.lineColor = const Color(0xFF648fd6),
    this.circleColor = const Color(0xFF34017e),
    this.enableImage = false,
    this.imageUrl = 'assets/images/male.png',
    this.isImageFromApi = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        enableImage
            ? isImageFromApi == false?
            CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 18,
                backgroundImage: AssetImage(imageUrl),
              ):
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 18,
                backgroundImage: NetworkImage(imageUrl),
              )
            : Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
              ),
        Container(
          width: 3,
          height: height,
          decoration: BoxDecoration(
            color: lineColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}

class CustomTimeLineDate extends StatelessWidget {
  final double? lineHeight;
  final String? text;
  final Color lineColor;
  final Color circleBorderColor;
  final Color circleBgColor;
  const CustomTimeLineDate({super.key, 
    @required this.lineHeight,
    @required this.text,
    this.lineColor = const Color(0xFF648fd6),
    this.circleBorderColor = const Color(0xFF34017e),
    this.circleBgColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   width: 18,
        //   height: 18,
        //   decoration: new BoxDecoration(
        //     color: cViolet,
        //     shape: BoxShape.circle,
        //   ),
        // ),
        Container(
          width: 3,
          height: lineHeight,
          decoration: BoxDecoration(
            color: lineColor,
            shape: BoxShape.rectangle,
          ),
        ),
        Container(
          width: 53,
          height: 53,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: circleBorderColor,
            ),
            shape: BoxShape.circle,
            // You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: circleBgColor,
          ),
          child: Center(
            child: Text(
              text??'',
              style: TextStyle(
                color: Colors.green[600],
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 3,
          height: lineHeight,
          decoration: BoxDecoration(
            color: lineColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}

class CustomTimeLineEnd extends StatelessWidget {
  final double? lineHeight;
  final String? text;
  final Color lineColor;
  final Color circleBorderColor;
  final Color circleBgColor;
  const CustomTimeLineEnd({super.key, 
    @required this.lineHeight,
    @required this.text,
    this.lineColor = const Color(0xFF648fd6),
    this.circleBorderColor = const Color(0xFF34017e),
    this.circleBgColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: circleBorderColor,
        ),
        shape: BoxShape.circle,
        // You can use like this way or like the below line
        //borderRadius: new BorderRadius.circular(30.0),
        color: circleBgColor,
      ),
      child: Center(
        child: Text(
          text??'',
          style: TextStyle(
            color: Colors.green[600],
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
