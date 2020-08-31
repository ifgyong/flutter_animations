import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';
import 'package:flutter_animations/widget/chakra_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool _isStop = false;
  Widget _row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SoundWidget(
          color: Colors.black,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          stop: _isStop,
//          radius: 100,
          soundDirection: SoundDirection.left,
        ),
        SoundWidget(
          color: Colors.green,
          lines: 4,
          lineWidth: 2,
          centerFill: true,
//          radius: 100,
          stop: _isStop,

          soundDirection: SoundDirection.top,
        ),
        SoundWidget(
          color: Colors.red,
          stop: _isStop,

          lines: 3,
          lineWidth: 2,
          centerFill: true,
//          radius: 100,
          soundDirection: SoundDirection.right,
        ),
        SoundWidget(
          color: Colors.orange,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          stop: _isStop,

//          radius: 100,
          soundDirection: SoundDirection.down,
        ),
        SoundWidget(
          color: Colors.orange,
          stop: _isStop,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          startAngle: 0,
          sweepAngle: pi * 2,
          soundDirection: SoundDirection.down,
        ),
        SoundWidget(
          color: Colors.blue,
          stopColor: Colors.black,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          stop: _isStop,
          startAngle: pi / 8,
          sweepAngle: pi * 2 / 1.25,
          soundDirection: SoundDirection.down,
        ),
      ],
    );
  }

  Widget get _widget => SliverToBoxAdapter(
        child: Container(
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

  /// 奇异博士 魔法动画
  Widget get _chakra => SliverToBoxAdapter(
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Container(
            child: Chakra(),
            width: 100,
            height: 200,
          ),
          height: 250,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _row1(),
          ),
          _widget,
          _chakra
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isStop = !_isStop;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
