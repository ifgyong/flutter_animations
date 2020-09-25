import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/25.
///

class ThreeDClockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<ThreeDClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3d时钟'),
      ),
      body: _body(),
      backgroundColor: Colors.black12,
    );
  }

  Widget _body() {
    return Center(
      child: Container(
        // width: 300,
        // height: 300,
        child: CustomPaint(
          painter: ClockPainter(second: second),
          size: Size(200, 200),
        ),
      ),
    );
  }

  int second = 0;
  Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (v) {
      if (mounted) {
        second = (second % 3600);
        second += 1;
        setState(() {});
      } else {
        v.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class ClockPainter extends CustomPainter {
  Paint _paint;

  TextPainter _textPainterTop;

  TextPainter _textPainterleft;

  TextPainter _textPainterRight;

  TextPainter _textPainterBottom;

  int second;
  ClockPainter({this.second = 0});
  void initTextPainter() {
    _textPainterTop ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '12', style: textStyle),
        textDirection: TextDirection.ltr);

    _textPainterleft ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '9', style: textStyle),
        textDirection: TextDirection.ltr);

    _textPainterRight ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '3', style: textStyle),
        textDirection: TextDirection.ltr);

    _textPainterBottom ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '6', style: textStyle),
        textDirection: TextDirection.ltr);
  }

  TextStyle get textStyle =>
      TextStyle(fontSize: 20, backgroundColor: Colors.black);

  @override
  void paint(Canvas canvas, Size size) {
    initTextPainter();

    _paint ??= Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2.0, size.height / 2.0);
    double radius = 100.0;
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    double shorterRadius = radius - 40;
    double outterRadius = radius - 20;
    double number = 120.0;
    for (var i = 0; i < number; ++i) {
      Offset p1 = Offset(center.dx + shorterRadius * (cos(i / number * pi * 2)),
          center.dy + shorterRadius * (sin(i / number * pi * 2)));
      Offset p2 = Offset(center.dx + outterRadius * (cos(i / number * pi * 2)),
          center.dy + outterRadius * (sin(i / number * pi * 2)));

      canvas.drawLine(p1, p2, _paint);
    }
    canvas.drawArc(rect, 0, pi * 2, false, _paint);

    /// 圆心
    double shorterCircleRadius = 6;
    Rect smaillRect =
        Rect.fromCircle(center: center, radius: shorterCircleRadius);
    _paint.strokeWidth = 5.0;
    canvas.drawArc(smaillRect, 0, pi * 2, false, _paint);

    /// 时针
    double _hourPi = pi / 3;
    double _hourLength = shorterCircleRadius + 20;
    Offset _hourFrom = Offset(center.dx + shorterCircleRadius * (cos(_hourPi)),
        center.dy + shorterCircleRadius * (sin(_hourPi)));
    Offset _hourTo = Offset(center.dx + (_hourLength) * (cos(_hourPi)),
        center.dy + (_hourLength) * (sin(_hourPi)));

    canvas.drawLine(_hourFrom, _hourTo, _paint);

    /// 分针
    double _miPi = pi / 6;
    double _miLength = shorterCircleRadius + 40;
    Offset _miFrom = Offset(center.dx + shorterCircleRadius * (cos(_miPi)),
        center.dy + shorterCircleRadius * (sin(_miPi)));
    Offset _miTo = Offset(center.dx + (_miLength) * (cos(_miPi)),
        center.dy + (_miLength) * (sin(_miPi)));
    canvas.drawLine(_miFrom, _miTo, _paint);

    /// 秒针
    double _sPi = pi * 2 * second / 60.0;
    double _sLength = shorterCircleRadius + 50;
    Offset _sFrom = Offset(center.dx + shorterCircleRadius * (cos(_sPi)),
        center.dy + shorterCircleRadius * (sin(_sPi)));
    Offset _sTo = Offset(center.dx + (_sLength) * (cos(_sPi)),
        center.dy + (_sLength) * (sin(_sPi)));
    _paint.strokeWidth = 2.0;
    canvas.drawLine(_sFrom, _sTo, _paint);

    drawText(canvas, size);
  }

  void drawText(Canvas canvas, Size size) {
    _textPainterleft.layout();
    _textPainterleft.paint(
        canvas, Offset(0 - _textPainterleft.width / 2, size.height / 2.0));
    _textPainterTop.layout();
    _textPainterTop.paint(
        canvas,
        Offset(size.width / 2.0 - _textPainterTop.width / 2,
            -_textPainterTop.height / 2));
    _textPainterRight.layout();
    _textPainterRight.paint(canvas,
        Offset(size.width - _textPainterRight.width / 2, size.height / 2.0));
    _textPainterBottom.layout();
    _textPainterBottom.paint(
        canvas,
        Offset(size.width / 2 - _textPainterBottom.width,
            size.height - _textPainterBottom.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
