import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/cancel_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/pause_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/resume_timer_button.dart';
import 'package:panda_tomato/UI/pages/home_page/widgets/clock_button_area/widgets/start_timer_button.dart';
import '../../utils/timer_state.dart';

class ClockButtonArea extends StatefulWidget {
  final void Function(int) setShowedTime;
  final TimerState timerState;
  final Function(TimerState) setTimerState;
  final Function(int) setTime;
  final Function() cancelTimer;
  final Future<void> Function() startCount;

  const ClockButtonArea({
    super.key,
    required this.setShowedTime,
    required this.timerState,
    required this.setTimerState,
    required this.setTime,
    required this.cancelTimer,
    required this.startCount,
  });

  @override
  State<ClockButtonArea> createState() => _ClockButtonAreaState();
}

class _ClockButtonAreaState extends State<ClockButtonArea> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: switch (widget.timerState) {
            TimerState.beforeStart => [
              StartTimerButton(
                setShowedTime: widget.setShowedTime,
                setTimerState: widget.setTimerState,
                setTime: widget.setTime,
                startCount: widget.startCount,
              ),
            ],
            TimerState.started => [
              PauseTimerButton(setTimerState: widget.setTimerState),
              CancelTimerButton(cancel: widget.cancelTimer),
            ],
            TimerState.paused => [
              ResumeTimerButton(
                setTimerState: widget.setTimerState,
                startCount: widget.startCount,
              ),
              CancelTimerButton(cancel: widget.cancelTimer),
            ],
          },
        ),
      ),
    );
  }
}
