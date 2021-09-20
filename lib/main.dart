import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => 'この文字が見えていますか？\nこの文字データをこのまま受け取ります',
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PageA(),
      ),
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
