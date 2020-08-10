import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/10.
///

// ignore: must_be_immutable
class SoundWidget extends StatefulWidget {
  Color color;
  Color bgColor;
  Color stopColor;
  bool stop;
  double radius;
  double lineWidth;
  double startAngle, sweepAngle;
  int lines;
  Duration duration;
  bool centerFill;
  SoundDirection soundDirection;

  ///https://github.com/ifgyong/FYAnimations
  /// 类似微信语音的动画，功能更强大，支持
  /// color 前景色
  /// bgColor 背景颜色
  /// stop 是否停止
  /// stopColor 停止时的颜色
  /// radius 直径
  /// lineWidth 线的宽度
  /// startAngle 开始弧度
  /// sweepAngle 结束时的弧度
  /// lines 线条数量
  /// duration 动画周期 默认1s
  /// centerFill 中心是否实心 默认实心
  /// soundDirection 方向默认是左边 ，当设置[startAngle]和[sweepAngle]则方向被忽略
  SoundWidget(
      {Key key,
      this.color,
      this.bgColor,
      @required this.stop,
      this.stopColor,
      this.radius,
      this.lineWidth,
      this.startAngle,
      this.sweepAngle,
      this.lines,
      this.duration,
      this.centerFill,
      this.soundDirection}) {
    this.color ??= Colors.green;
    stopColor ??= Colors.black12;
    radius ??= 50;
    bgColor ??= Colors.black12;
    lineWidth ??= 4;
    duration ??= Duration(seconds: 1);
    centerFill ??= true;
  }
  @override
  _FYSoundWidgetState createState() => _FYSoundWidgetState();
}

class _FYSoundWidgetState extends State<SoundWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (ctx, child) {
          return CustomPaint(
            painter: _CustomSoundWidget(
                value: _animationController.value,
                color: widget.color,
                bgColor: widget.bgColor,
                stop: widget.stop,
                stopColor: widget.stopColor,
                lineWidth: widget.lineWidth,
                lines: widget.lines,
                centerFill: widget.centerFill,
                startAngle: widget.startAngle,
                sweepAngle: widget.sweepAngle,
                soundDirection: widget.soundDirection),
            size: Size(widget.radius, widget.radius),
          );
        },
      ),
    );
  }

  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum SoundDirection { top, down, left, right }

class _CustomSoundWidget extends CustomPainter {
  double value;
  double lineWidth;
  Color color;
  Color bgColor;
  Color stopColor;
  bool stop;
  double startAngle, sweepAngle;
  int lines;
  bool centerFill;
  SoundDirection soundDirection;

  _CustomSoundWidget(
      {this.value = 0.0,
      this.color,
      this.bgColor,
      this.stop,
      this.stopColor,
      this.lineWidth,
      this.startAngle,
      this.sweepAngle,
      this.lines,
      this.centerFill,
      this.soundDirection}) {
    if (startAngle == null && sweepAngle == null) {
      soundDirection ??= SoundDirection.left;
      switch (soundDirection) {
        case SoundDirection.left:
          startAngle = -pi / 4 * 3;
          sweepAngle = (-pi / 2);
          break;
        case SoundDirection.top:
          startAngle = -pi / 4 * 3;
          sweepAngle = (pi / 2);
          break;
        case SoundDirection.right:
          startAngle = -(pi / 4);
          sweepAngle = pi / 2;
          break;
        case SoundDirection.down:
          startAngle = pi / 4 * 3;
          sweepAngle = (-pi / 2);
          break;
      }
    }

    lines ??= 3;
//    lines += 1;
    centerFill ??= true;
  }

  Paint _paint;
  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..strokeWidth = lineWidth ?? 4
      ..style = PaintingStyle.stroke
      ..color = this.color;
    double sep = 0.9 / lines;
    for (var i = 0; i < lines; ++i) {
      if (value >= (0.9 - sep * i)) {
        _paint.color = this.color;
      } else {
        _paint.color = this.bgColor;
      }
      if (stop == true) {
        _paint.color = bgColor;
      }
      double wh = (1 - sep * i);
      bool point = false;
      if (i == lines - 1 && centerFill == true) {
        point = true;
        _paint.style = PaintingStyle.fill;
      } else {
        _paint.style = PaintingStyle.stroke;
      }
      canvas.drawArc(
          Rect.fromCenter(
              center: Offset(size.width, size.height / 2),
              width: size.width * wh,
              height: size.height * wh),
          startAngle,
          sweepAngle,
          point,
          _paint);
    }
  }

  @override
  bool shouldRepaint(_CustomSoundWidget oldDelegate) {
    return oldDelegate.value != value ||
        this.stop != oldDelegate.stop ||
        oldDelegate.color != color ||
        oldDelegate.bgColor != bgColor ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.soundDirection != soundDirection ||
        oldDelegate.sweepAngle != sweepAngle;
  }
}
