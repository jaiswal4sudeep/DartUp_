import 'package:flutter/material.dart';
import 'package:task/utils/app_constant.dart';

class Arc extends CustomPainter {
  double seconds;

  Arc({
    required this.seconds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = AppConstant.titlecolor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(
      const Offset(0, 0) & const Size(125, 125),
      0, //radians
      seconds, //radians
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
