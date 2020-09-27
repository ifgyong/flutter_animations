import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/widget/clock.dart';

///
/// Created by fgyong on 2020/9/27.
///
class ThreePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3d闹钟'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: ThreeDClock(),
        ),
      ),
      backgroundColor: Color.fromRGBO(57, 124, 170, 1),
    );
  }
}
