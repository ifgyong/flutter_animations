import 'dart:math';

import 'package:example/page/flash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';

import 'page/chakra.dart';
import 'page/red_broken.dart';
import 'page/spin.dart';

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

  Widget _redPointBroken() {
    return SliverToBoxAdapter(
      child: OutlineButton(
        child: Text('红色破碎'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => RedExamplePage()));
        },
      ),
    );
  }

  Widget _titleAndPushWidget({String title, Widget widget}) {
    return SliverToBoxAdapter(
      child: OutlineButton(
        child: Text(title),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
        },
      ),
    );
  }

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
            child: SizedBox(
              height: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: _row1(),
          ),
          _titleAndPushWidget(title: '魔法动画', widget: ChaKraPage()),
          _titleAndPushWidget(title: '音乐跳动', widget: SpinPage()),
          _titleAndPushWidget(title: '红色破碎', widget: RedExamplePage()),
          _titleAndPushWidget(title: '无数据闪光效果', widget: BaseFlashPage()),
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
