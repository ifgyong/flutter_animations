import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';

///
/// Created by fgyong on 2020/9/15.
///

class BaseFlashPage extends StatefulWidget {
  BaseFlashPage({Key key}) : super(key: key);

  String get routeName => 'BaseFlashPage';
  @override
  _BaseFlashPageState createState() => _BaseFlashPageState();
}

class _BaseFlashPageState extends State<BaseFlashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('无数据 默认效果'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            bottom: 0,
            child: IgnorePointer(
              child: ListView.builder(
                itemBuilder: _cellBuild,
                itemCount: 10,
                padding: EdgeInsets.only(left: 20, right: 20),
              ),
            )),
        Positioned.fill(
          child: FlashPage(),
          bottom: 0,
        ),
      ],
    );
  }

  Widget _cellBuild(context, index) {
    const cl = const Color.fromRGBO(230, 230, 230, 1);
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: const Color.fromRGBO(248, 248, 248, 1),
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            margin: EdgeInsets.only(right: 260),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: cl,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: cl,
            ),
            height: 20,
            margin: EdgeInsets.only(right: 200),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: cl,
            ),
            height: 20,
            margin: EdgeInsets.only(right: 120),
          ),
          SizedBox(
            height: 10,
          ),
          _line(),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 0.3,
      color: Colors.black38,
      margin: EdgeInsets.only(left: 10),
    );
  }
}
