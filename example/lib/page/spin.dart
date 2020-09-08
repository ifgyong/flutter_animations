import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';

///
/// Created by fgyong on 2020/9/8.
///

class SpinPage extends StatefulWidget {
  SpinPage({Key key}) : super(key: key);

  @override
  _SpinPageState createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圈圈'),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Container(
          child: Spinnies(
              duration: Duration(seconds: 6), blendMode: BlendMode.screen),
          width: 200,
          height: 200,
        ),
        height: 250,
      ),
    );
  }

  Widget _body() {}
}
