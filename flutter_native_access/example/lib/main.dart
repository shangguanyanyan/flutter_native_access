import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutternativeaccess/flutternativeaccess.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool isScreenOn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Flutternativeaccess.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  bool _toogleScreenOn() {
    isScreenOn = !isScreenOn;
    return isScreenOn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Running on: $_platformVersion\n'),
              ),
              RaisedButton(
                onPressed: () {
                  Flutternativeaccess.keepScreenOn(_toogleScreenOn()).then((_) {
                    setState(() {});
                  });
                },
                child: Text("屏幕常亮：$isScreenOn"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
