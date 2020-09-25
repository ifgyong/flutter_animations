import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/widget/chakra_widget.dart';

///
/// Created by fgyong on 2020/9/8.
///

class ChaKraPage extends StatefulWidget {
  /// 奇异博士 魔法动画
  ChaKraPage({Key key}) : super(key: key);

  @override
  _ChaKraPageState createState() => _ChaKraPageState();
}

class _ChaKraPageState extends State<ChaKraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Container(
        child: Chakra(),
        width: 100,
        height: 200,
      ),
      height: 250,
    );
  }
}
