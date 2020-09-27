import 'dart:async';
import 'dart:math';

import 'drag_direction_gestureRecognizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/25.
///

class ThreeDClock extends StatefulWidget {
  final Color circleColor;
  final Color clockLinesColor;
  final Color centerColor;
  final Color secondHandColor;
  final Color hourHandColor;
  final Color mintueColor;
  final Color backgroundColor;
  final Color lightclockLinesColor;

  /// 秒针画几个格子,最好是12的倍数例如[12,24,48,96,108,120,132,144,156,180]
  final int numbers;
  final TextStyle textStyle;

  /// 范围[0,2π]
  final double tailLength;
  ThreeDClock(
      {this.centerColor,
      this.circleColor,
      this.clockLinesColor,
      this.hourHandColor,
      this.mintueColor,
      this.secondHandColor,
      this.numbers,
      this.backgroundColor,
      this.lightclockLinesColor,
      this.tailLength,
      this.textStyle})
      : assert(() {
          if (tailLength != null) {
            return tailLength > 0 && tailLength < 2 * pi;
          }
          return true;
        }());
  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<ThreeDClock> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return RawGestureDetector(
      gestures: _contentGestures,
      child: AnimatedBuilder(
        builder: (context, child) {
          return Transform(
            transform: _dragEnd == true
                ? (Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX(_offset.dy / 414 * pi / 4 * _animation.value)
                  ..rotateY(_offset.dx / 1000 * pi / -4 * _animation.value))
                : (Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX(_offset.dy / 414 * pi / 4)
                  ..rotateY(_offset.dx / 1000 * pi / -4)),
            alignment: Alignment.center,
            child: CustomPaint(
              painter: ClockPainter(
                  centerColor: Colors.orange,
                  circleColor: widget.circleColor,
                  hourHandColor: widget.hourHandColor,
                  mintueColor: widget.mintueColor,
                  lightclockLinesColor: widget.lightclockLinesColor,
                  backgroundColor: widget.backgroundColor,
                  clockLinesColor: widget.clockLinesColor,
                  textStyle: widget.textStyle,
                  secondHandColor: widget.secondHandColor,
                  numbers: 180),
              // size: Size(200, 200),
            ),
          );
        },
        animation: _animationController,
      ),
      behavior: HitTestBehavior.deferToChild,
    );
  }

  Timer _timer;
  Offset _startOffset = Offset.zero;
  bool _dragEnd;

  Offset _offset = Offset.zero;
  Matrix4 matrix4;
  AnimationController _animationController;

  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _dragEnd = false;
          _offset = Offset.zero;
          print('AnimationStatus.dismissed');
          if (mounted) setState(() {});
        }
      });
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.linear);

    matrix4 = Matrix4.identity();
    _timer = Timer.periodic(Duration(milliseconds: 160), (v) {
      if (mounted) {
        setState(() {});
      } else {
        v.cancel();
      }
    });
    initGestures();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Map<Type, GestureRecognizerFactory> _contentGestures;

  // ignore: cancel_subscriptions
  void initGestures() {
    _contentGestures = {
      DirectionGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<DirectionGestureRecognizer>(
              () => DirectionGestureRecognizer(DirectionGestureRecognizer.all),
              (instance) {
        instance.onDown = _onDown;
        instance.onStart = _onStart;
        instance.onUpdate = _onUpdate;
        instance.onCancel = () {};
        instance.onEnd = _onEnd;
      }),
      TapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(), (instance) {
        instance.onTap = null;
      })
    };
  }

  void _onDown(DragDownDetails details) {
    _startOffset = details.globalPosition;
  }

  void _onStart(DragStartDetails details) {
    _startOffset = details.globalPosition;
  }

  void _onUpdate(DragUpdateDetails details) {
    _offset = Offset(details.globalPosition.dx - _startOffset.dx,
        details.globalPosition.dy - _startOffset.dy);
    setState(() {
      matrix4 = Matrix4.identity()
        ..setEntry(3, 2, 0.0011)
        ..rotateX(_offset.dy / 414 * pi / 4)
        ..rotateY(_offset.dx / 1000 * pi / -4);
    });
  }

  void _onEnd(DragEndDetails details) {
    _dragEnd = true;
    _animationController.reset();
    _animationController.reverse(
      from: 1.0,
    );
  }
}

class ClockPainter extends CustomPainter {
  Paint _paint;

  TextPainter _textPainterTop;

  TextPainter _textPainterleft;

  TextPainter _textPainterRight;

  TextPainter _textPainterBottom;

  final Color circleColor;
  final Color clockLinesColor;
  final Color centerColor;
  final Color secondHandColor;
  final Color hourHandColor;
  final Color mintueColor;
  final Color backgroundColor;
  final Color lightclockLinesColor;

  /// 秒针画几个格子,最好是12的倍数例如[12,24,48,96,108,120,132,144,156,180]
  final int numbers;
  final TextStyle textStyle;

  /// 范围[0,2π]
  final double tailLength;

  ClockPainter(
      {this.centerColor,
      this.circleColor,
      this.clockLinesColor,
      this.hourHandColor,
      this.mintueColor,
      this.secondHandColor,
      this.numbers,
      this.backgroundColor,
      this.lightclockLinesColor,
      this.tailLength,
      this.textStyle})
      : assert(() {
          if (tailLength != null) {
            return tailLength > 0 && tailLength < 2 * pi;
          }
          return true;
        }());
  void initTextPainter() {
    _textPainterTop ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '12', style: defaultTextStyle),
        textDirection: TextDirection.ltr);

    _textPainterleft ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '9', style: defaultTextStyle),
        textDirection: TextDirection.ltr);

    _textPainterRight ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '3', style: defaultTextStyle),
        textDirection: TextDirection.ltr);

    _textPainterBottom ??= TextPainter(
        textAlign: TextAlign.center,
        maxLines: 1,
        text: TextSpan(text: '6', style: defaultTextStyle),
        textDirection: TextDirection.ltr);
  }

  TextStyle get defaultTextStyle =>
      textStyle ??
      TextStyle(
          fontSize: 20,
          backgroundColor: backgroundColor ?? Color.fromRGBO(57, 124, 170, 1),
          color: Colors.white38);

  @override
  void paint(Canvas canvas, Size size) {
    initTextPainter();

    _paint ??= Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2.0, size.height / 2.0);
    double radius = size.width / 2.0;
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    /// 圆圈
    _paint.color = circleColor ?? Colors.white38;
    canvas.drawArc(rect, 0, pi * 2, false, _paint);

    _paint.color = centerColor ?? Colors.white;

    /// 圆心
    double shorterCircleRadius = radius * 0.06;
    Rect smaillRect =
        Rect.fromCircle(center: center, radius: shorterCircleRadius);
    _paint.strokeWidth = radius * 0.05;
    canvas.drawArc(smaillRect, 0, pi * 2, false, _paint);

    var date = DateTime.now();
    _paint.color = hourHandColor ?? Colors.white.withOpacity(0.5);

    /// 时针
    double _hourPi = pi * 2 * date.hour / 12.0 - pi / 2;
    double _hourLength = shorterCircleRadius + radius * 0.2;
    Offset _hourFrom = Offset(center.dx + shorterCircleRadius * (cos(_hourPi)),
        center.dy + shorterCircleRadius * (sin(_hourPi)));
    Offset _hourTo = Offset(center.dx + (_hourLength) * (cos(_hourPi)),
        center.dy + (_hourLength) * (sin(_hourPi)));

    canvas.drawLine(_hourFrom, _hourTo, _paint);

    _paint.color = mintueColor ?? Colors.white;

    /// 分针
    double _miPi = pi * 2 * date.minute / 60.0 - pi / 2;
    double _miLength = shorterCircleRadius + radius * 0.4;
    Offset _miFrom = Offset(center.dx + shorterCircleRadius * (cos(_miPi)),
        center.dy + shorterCircleRadius * (sin(_miPi)));
    Offset _miTo = Offset(center.dx + (_miLength) * (cos(_miPi)),
        center.dy + (_miLength) * (sin(_miPi)));
    canvas.drawLine(_miFrom, _miTo, _paint);
    _paint.color = secondHandColor ?? Colors.white;

    /// 秒针
    double _sPi =
        pi * 2 * (date.second / 60.00 + date.millisecond / 1000.0 / 60) -
            pi / 2;

    double _sLength = shorterCircleRadius + radius * 0.5;
    Offset _sFrom = Offset(center.dx + shorterCircleRadius * (cos(_sPi)),
        center.dy + shorterCircleRadius * (sin(_sPi)));
    Offset _sTo = Offset(center.dx + (_sLength) * (cos(_sPi)),
        center.dy + (_sLength) * (sin(_sPi)));
    _paint.strokeWidth = radius * 0.02;
    canvas.drawLine(_sFrom, _sTo, _paint);

    double shorterRadius = radius * 0.6;
    double outterRadius = radius * 0.8;
    double number = numbers?.toDouble() ?? 180.0;
    _paint.color = circleColor ?? Colors.white.withOpacity(0.3);

    for (var i = 0; i < number; ++i) {
      double currentLine = i / number * pi * 2 - pi / 2;
      Offset _pointFrom = Offset(center.dx + shorterRadius * (cos(currentLine)),
          center.dy + shorterRadius * (sin(currentLine)));
      Offset _pointTo = Offset(center.dx + outterRadius * (cos(currentLine)),
          center.dy + outterRadius * (sin(currentLine)));

      /// 画 秒针很后边的 渐变色
      double distance = pi * 0.5;

      if (_sPi - currentLine <= distance && (_sPi - currentLine) >= 0) {
        double abs = _sPi - currentLine;
        double a = (1 - abs / distance) * 0.7 + 0.3;
        _paint.color =
            (lightclockLinesColor ?? Colors.white).withOpacity(a.abs());
      } else if (_sPi + pi * 2 - currentLine < distance) {
        /// 根据和指针距离来计算位移颜色渐变
        double abs = _sPi + pi * 2 - currentLine;

        double a = (1 - abs / distance) * 0.7 + 0.3;
        _paint.color =
            (lightclockLinesColor ?? Colors.white).withOpacity(a.abs());
      } else {
        _paint.color = (lightclockLinesColor ?? Colors.white).withOpacity(0.3);
      }
      canvas.drawLine(_pointFrom, _pointTo, _paint);
    }

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
