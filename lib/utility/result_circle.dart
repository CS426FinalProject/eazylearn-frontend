import 'dart:math';
import 'dart:ui' as ui;
import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

class ResultCircle extends StatelessWidget {
  final int questionNumber;
  final int corrects;

  const ResultCircle({@required this.questionNumber, @required this.corrects});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _CircularProgress(corrects / questionNumber * 100),
      child: SizedBox(
        height: 300,
        width: 300,
      ),
    );
  }
}

class _CircularProgress extends CustomPainter {
  double currentProgress;

  _CircularProgress(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.redAccent
      ..shader = ui.Gradient.linear(
          Offset(0, 0),
          Offset(size.width, size.height),
          <Color>[resultCircle1, resultCircle2])
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
