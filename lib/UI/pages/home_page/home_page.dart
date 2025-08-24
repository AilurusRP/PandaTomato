import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/utils/timer_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/time_utils.dart';
import 'widgets/clock_button_area/clock_button_area.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _showedTime = "0:00:00";
  TimerState _timerState = TimerState.beforeStart;
  late int _time;

  @override
  void initState() {
    checkTimerDataCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 550,
            width: double.infinity,
            child: Center(
              child: Text(_showedTime, style: TextStyle(fontSize: 56)),
            ),
          ),
          Divider(),
          ClockButtonArea(
            setShowedTime: (restTime) {
              setState(() {
                _showedTime = toShowedTime(restTime);
              });
            },
            timerState: _timerState,
            setTimerState: setTimerState,
            setTime: setTime,
            cancelTimer: cancelTimer,
            startCount: startCount,
          ),
        ],
      ),
    );
  }

  void setTimerState(TimerState newState) {
    setState(() {
      _timerState = newState;
    });
  }

  void setTime(int time) {
    _time = time;
  }

  Future<void> startCount() async {
    while (_time > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (_timerState == TimerState.paused ||
          _timerState == TimerState.beforeStart) {
        return;
      }
      _time--;
      setShowedTime(_time);
    }
    cancelTimer();
  }

  void cancelTimer() {
    _time = 0;
    setShowedTime(0);
    setTimerState(TimerState.beforeStart);
  }

  void setShowedTime(int restTime) {
    setState(() {
      _showedTime = toShowedTime(restTime);
    });
  }

  Future<void> checkTimerDataCache() async {
    var prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );

    String? timerDataString = await prefs.getString("timerData");
    if (timerDataString != null) {
      var timerData = json.decode(timerDataString);
      int currentTime = DateTime.now().millisecondsSinceEpoch;

      if (timerData["currentTimestamp"] != null &&
          timerData["totalTime"] != null) {
        num pastTime = (currentTime - timerData["currentTimestamp"]!) ~/ 1000;
        int restTime = timerData["totalTime"]! - pastTime;

        if (restTime > 0) {
          setTime(restTime);
          startCount();
          setTimerState(TimerState.started);
        }
      }
    }
  }
}
