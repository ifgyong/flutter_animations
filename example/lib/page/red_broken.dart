import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations.dart';

///
/// Created by fgyong on 2020/9/8.
///

class RedExamplePage extends StatefulWidget {
  RedExamplePage({Key key}) : super(key: key);

  @override
  _RedExamplePageState createState() => _RedExamplePageState();
}

class _RedExamplePageState extends State<RedExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('红点破碎'),
      ),
      body: CustomScrollView(
        slivers: [_sliverList()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }

  Widget _sliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            key: UniqueKey(),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text('title'),
                      Expanded(
                        child: SizedBox(),
                        flex: 1,
                      ),
                      BrokenRedDot(
                        radius: 10,
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  height: 50,
                ),
                Container(
                  child: Text('我是内容，今天天气好清凉'),
                )
              ],
            ),
            height: 100,
          );
        },
        childCount: 10,
      ),
    );
  }
}
