import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';

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

  Widget _row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SoundWidget(
          color: Colors.black,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          radius: 100,
        ),
        SoundWidget(
          color: Colors.green,
          lines: 4,
          lineWidth: 2,
          centerFill: true,
          radius: 100,
          startAngle: -pi * 3 / 4,
          sweepAngle: 0,
        ),
        SoundWidget(
          color: Colors.black,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          radius: 100,
        ),
        SoundWidget(
          color: Colors.black,
          lines: 3,
          lineWidth: 2,
          centerFill: true,
          radius: 100,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _row1(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
