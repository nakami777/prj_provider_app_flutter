import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => 'この文字が見えていますか？\nこの文字データをこのまま受け取ります\n右下のボタンをタップしてください',
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ParentWidget(),
      ),
    );
  }
}

class CountData extends ChangeNotifier {
  int count = 0;

  void increment() {
    count = count + 1;
    notifyListeners();
  }
}

class ParentWidget extends StatelessWidget {
  final data = CountData();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountData>.value(
      value: data,
      child: Container(
        child: ChildWidget(),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CountData data = context.watch<CountData>();

    return Column(
      children: <Widget>[
        Center(
          child: Text('ボタンを何回\n押しましたか？\n ${data.count.toString()} 回です'),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              data.increment();
            },
            child: Text('ボタン'),
          ),
          width: 100,
          height: 40,
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PageA()),
              );
            },
            child: Text('ページ間のデータ受け取り\nはこちら'),
          ),
          width: 200,
          height: 80,
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        ),
      ],
    );
  }
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.watch<String>()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PageB()),
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.watch<String>()),
      ),
    );
  }
}
