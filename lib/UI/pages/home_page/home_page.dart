import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/utils/timer_cache_utils.dart';
import 'package:panda_tomato/UI/pages/home_page/utils/timer_state.dart';
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
  int _timeCount = 0;

  @override
  void initState() {
    checkTimerDataCacheOnInit();
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
            timeCount: _timeCount,
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
    _timeCount = time;
  }

  Future<void> startCount() async {
    while (_timeCount > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (_timerState == TimerState.paused ||
          _timerState == TimerState.beforeStart) {
        return;
      }
      _timeCount--;
      setShowedTime(_timeCount);
    }
    cancelTimer();
  }

  void cancelTimer() {
    var timerCache = TimerCacheUtils();
    timerCache.clearCache();
    _timeCount = 0;
    setShowedTime(0);
    setTimerState(TimerState.beforeStart);
  }

  void setShowedTime(int restTime) {
    setState(() {
      _showedTime = toShowedTime(restTime);
    });
  }

  Future<void> checkTimerDataCacheOnInit() async {
    var timerCache = TimerCacheUtils();

    bool? paused = await timerCache.getPausedCache();
    print("ppppppppppppppppppppppppppppppppppppp");
    print(paused);
    if (paused == null) return;

    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int initialTimestamp = (await timerCache.getInitialTimestampCache())!;
    print(initialTimestamp);
    int restTimeFromCache = (await timerCache.getRestTimeCache())!;

    if (!paused) {
      int pastTime = (currentTime - initialTimestamp) ~/ 1000;
      int restTime = restTimeFromCache - pastTime;
      if (restTime > 0) {
        setTime(restTime);
        startCount();
        setTimerState(TimerState.started);
      }
    } else {
      timerCache.setInitialTimestampCache(currentTime);
      setTime(restTimeFromCache);
      setShowedTime(restTimeFromCache);
      setTimerState(TimerState.paused);
    }
  }
}
