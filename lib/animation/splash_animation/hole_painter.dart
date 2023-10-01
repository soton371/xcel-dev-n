import 'package:flutter/material.dart';

class HolePainter extends CustomPainter {
  HolePainter({
     this.color,
     this.holeSize,
  });

  Color? color;
  double? holeSize;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = (holeSize ?? 100) / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    Rect innerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius / 2);

    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );

    Path halfTransparentRing = Path.combine(
      PathOperation.difference,
      Path()
        ..addOval(outerCircleRect)
        ..close(),
      Path()
        ..addOval(innerCircleRect)
        ..close(),
    );

    canvas.drawPath(transparentHole, Paint()..color = color ?? Colors.blue);
    canvas.drawPath(
        halfTransparentRing, Paint()..color = color != null ? color!.withOpacity(0.5): Colors.blue.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
