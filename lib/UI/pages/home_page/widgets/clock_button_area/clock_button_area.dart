import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/cancel_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/pause_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/resume_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/start_timer_button.dart';
import '../../utils/timer_state.dart';

class ClockButtonArea extends StatefulWidget {
  final void Function(int) setShowedTime;

  const ClockButtonArea({super.key, required this.setShowedTime});

  @override
  State<ClockButtonArea> createState() => _ClockButtonAreaState();
}

class _ClockButtonAreaState extends State<ClockButtonArea> {
  TimerState _timerState = TimerState.beforeStart;
  late int _time;

  setTimerState(TimerState newState) {
    setState(() {
      _timerState = newState;
    });
  }

  setTime(int time) {
    _time = time;
  }

  count() async {
    while (_time > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (_timerState == TimerState.paused ||
          _timerState == TimerState.beforeStart) {
        return;
      }
      _time--;
      widget.setShowedTime(_time);
    }
    cancel();
  }

  cancel() {
    _time = 0;
    widget.setShowedTime(0);
    setTimerState(TimerState.beforeStart);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: switch (_timerState) {
            TimerState.beforeStart => [
              StartTimerButton(
                setShowedTime: widget.setShowedTime,
                setTimerState: setTimerState,
                setTime: setTime,
                count: count,
              ),
            ],
            TimerState.started => [
              PauseTimerButton(setTimerState: setTimerState),
              CancelTimerButton(cancel: cancel),
            ],
            TimerState.paused => [
              ResumeTimerButton(setTimerState: setTimerState, count: count),
              CancelTimerButton(cancel: cancel),
            ],
          },
        ),
      ),
    );
  }
}
