import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panda_tomato/my_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController? _timeController = TextEditingController();
  String _showedTime = "00:00:00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(controller: _timeController),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    if (_timeController == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("未知错误：_timeController为null"),
                          );
                        },
                      );
                    } else if (_timeController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(content: Text("时间不能为空！"));
                        },
                      );
                    } else if (!_timeController.text.contains(
                          RegExp(r"^[0-9:]+$"),
                        ) ||
                        _timeController.text.split(":").length > 3 ||
                        _timeController.text
                            .split(":")
                            .any(
                              (item) =>
                                  int.parse(item) >= 60 || int.parse(item) < 0,
                            )) {
                      // 时间只能为nn:nn:nn或nn:nn或nn的格式
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(content: Text("时间格式错误！"));
                        },
                      );
                    } else {
                      int time = _getTime(_timeController.text);
                      MyTimer timer = MyTimer.getTimer(time);
                      timer.count((t) {
                        setState(() {
                          _showedTime = _toShowedTime(t);
                        });
                      });
                    }
                  },
                  child: Text("开始"),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              // decoration: BoxDecoration(color: Colors.grey),
              child: Center(
                child: Text(_showedTime, style: TextStyle(fontSize: 56)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int _getTime(String rawTimeString) {
  List<int> timeLst = rawTimeString
      .split(":")
      .map<int>((item) => int.parse(item))
      .toList();

  return timeLst.reduce((val, com) => 60 * val + com);
}

String _toShowedTime(int time) {
  int t = time;
  int hours = t ~/ 3600;
  t = t % 3600;
  int minutes = t ~/ 60;
  t = t % 60;
  int seconds = t;

  String secStr = seconds >= 10 ? seconds.toString() : "0$seconds";
  String minStr = minutes >= 10 ? minutes.toString() : "0$minutes";
  String hrStr = hours.toString();

  return "$hrStr:$minStr:$secStr";
}
