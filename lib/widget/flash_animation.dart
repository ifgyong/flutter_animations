import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/15.
///

class FlashPage extends StatefulWidget {
  /// 闪光 偏移量 x：横轴 [-1,1] y:纵轴[-1,1]
  final Offset offset;

  /// 闪光的颜色
  final List<Color> colors;

  /// 闪光步长，数组长度保持和[colors]一致
  final List<double> steps;

  FlashPage({Key key, this.offset, this.colors, this.steps}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlashPageState();
  }
}

class _FlashPageState extends State<FlashPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Container(
          child: CustomPaint(
            painter: _BaseShine(
                value: _animationController.value,
                widthValue: 0.2,
                colors: colors,
                steps: steps),
          ),
          transform: Matrix4.skew(offset.dx, offset.dy),
        );
      },
      animation: _animationController,
    );
  }

  Offset get offset => widget.offset ?? Offset(-0.3, 0);
  List<Color> get colors => widget.colors;

  List<double> get steps => widget.steps;

  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _BaseShine extends CustomPainter {
  final double value;
  final double widthValue;

  final Color bacgkgroundColor;
  _BaseShine(
      {this.value,
      this.widthValue,
      this.colors,
      this.steps,
      this.bacgkgroundColor})
      : assert(() {
          if (colors != null && steps != null) {
            return colors.length == steps.length;
          } else if (colors == null && steps == null) {
            return true;
          } else {
            return false;
          }
        }());
  final List<Color> colors;
  final List<double> steps;

  Path _path;
  Paint _paint;
  Gradient _gradient;
  @override
  void paint(Canvas canvas, Size size) {
    if (steps != null && colors != null) {
      _gradient ??= LinearGradient(
        colors: colors,
        stops: steps,
      );
    } else {
      _gradient ??= LinearGradient(colors: [
        Colors.white.withOpacity(0),
        Colors.white.withOpacity(1),
        Colors.white.withOpacity(0)
      ], stops: [
        0.33,
        0.66,
        1.0
      ]);
    }

    _path ??= Path();
    _paint ??= Paint()
      ..color = bacgkgroundColor ?? Colors.white
      ..style = PaintingStyle.fill;
    _paint.blendMode = BlendMode.softLight;
    double offset = value * size.width * 1.3;
    Rect rect = Rect.fromLTWH(offset, 0, size.width * widthValue, size.height);
    _paint.shader = _gradient.createShader(rect);

    _path.moveTo(offset, 0);
    _path.lineTo(rect.width + rect.left, 0);
    _path.lineTo(rect.width + rect.left, size.height);

    _path.lineTo(offset, rect.height);
    _path.lineTo(offset, 0);
    canvas.drawPath(_path, _paint);
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
