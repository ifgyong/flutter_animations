import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/8.
///

class BrokenRedDot extends StatefulWidget {
//  reddot redius default 10
  final double radius;

  /// 破碎的红点 用于文章 消息阅读阅后即焚效果
  BrokenRedDot({Key key, this.radius = 10}) : super(key: key);

  @override
  _BrokenRedDotState createState() => _BrokenRedDotState();
}

class _BrokenRedDotState extends State<BrokenRedDot>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Container(
      child: _animationStatus != AnimationStatus.completed
          ? AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: widget.radius * 2,
                  height: widget.radius * 2,
                  child: CustomPaint(
                    painter: _RedDotPaint(_animation.value),
                    size: Size(widget.radius * 2, widget.radius * 2),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
//              color: Colors.white,
                  ),
                );
              },
            )
          : null,
    );
  }

  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        lowerBound: 0.0,
        upperBound: 0.5)
      ..forward()
      ..addStatusListener((status) {
        _animationStatus = status;
        if (status == AnimationStatus.completed) {
          Timer(Duration(milliseconds: 300), () {
            setState(() {});
          });
        }
      });
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutQuad);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _RedDotPaint extends CustomPainter {
  Paint _paint;
//  default [0,1]
  final double value;
  _RedDotPaint(this.value);

  @override
  bool shouldRepaint(_RedDotPaint oldDelegate) {
    return oldDelegate.value != this.value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint ??= Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;
    double v = 0.5 - this.value;
    // 背景 红色图
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2.0, size.height / 2.0),
            radius: min<double>(size.width, size.height) / 2.0 * (0.5 + v)),
        0,
        pi * 2,
        false,
        _paint);

//第一个红点
    Offset _c1 = Offset(size.width / 2.0, size.height / 2.0 * v);
    double radius = min<double>(size.width, size.height) / 4.0 * (0.5 + v);
    canvas.drawArc(
        Rect.fromCircle(center: _c1, radius: radius), 0, pi * 2, false, _paint);
//第二个红点
    _c1 = Offset(size.width / 2.0 * (2 - v), size.height / 2.0 * (2 - v));
    canvas.drawArc(
        Rect.fromCircle(center: _c1, radius: radius), 0, pi * 2, false, _paint);
//    第三个红点
    _c1 = Offset(size.width / 2.0 * (v), size.height / 2.0 * (2 - v));
    canvas.drawArc(
        Rect.fromCircle(center: _c1, radius: radius), 0, pi * 2, false, _paint);
    canvas.clipRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
    );
  }
}
