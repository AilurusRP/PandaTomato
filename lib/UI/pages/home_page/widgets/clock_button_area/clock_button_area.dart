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

  setTimerState(TimerState newState) {
    _timerState = newState;
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
              ),
            ],
            TimerState.started => [
              PauseTimerButton(setTimerState: setTimerState),
              CancelTimerButton(setTimerState: setTimerState),
            ],
            TimerState.paused => [
              ResumeTimerButton(setTimerState: setTimerState),
              CancelTimerButton(setTimerState: setTimerState),
            ],
          },
        ),
      ),
    );
  }
}
