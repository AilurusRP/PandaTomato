import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/cancel_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/pause_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/resume_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/start_timer_button.dart';
import '../../utils/timer_state.dart';

class ClockButtonArea extends StatelessWidget {
  final void Function(int) setShowedTime;
  final TimerState timerState;
  final Function(TimerState) setTimerState;
  final Function(int) setTime;
  final Function() cancelTimer;
  final Future<void> Function() startCount;
  final int timeCount;

  const ClockButtonArea({
    super.key,
    required this.setShowedTime,
    required this.timerState,
    required this.setTimerState,
    required this.setTime,
    required this.cancelTimer,
    required this.startCount,
    required this.timeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: switch (timerState) {
            TimerState.beforeStart => [
              StartTimerButton(
                setShowedTime: setShowedTime,
                setTimerState: setTimerState,
                setTime: setTime,
                startCount: startCount,
              ),
            ],
            TimerState.started => [
              PauseTimerButton(
                setTimerState: setTimerState,
                timeCount: timeCount,
              ),
              CancelTimerButton(cancelTimer: cancelTimer),
            ],
            TimerState.paused => [
              ResumeTimerButton(
                setTimerState: setTimerState,
                startCount: startCount,
              ),
              CancelTimerButton(cancelTimer: cancelTimer),
            ],
          },
        ),
      ),
    );
  }
}
