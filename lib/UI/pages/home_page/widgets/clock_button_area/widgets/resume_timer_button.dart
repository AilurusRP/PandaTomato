import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class ResumeTimerButton extends StatefulWidget {
  final Function(TimerState) setTimerState;

  final Future<void> Function() startCount;

  const ResumeTimerButton({
    super.key,
    required this.setTimerState,
    required this.startCount,
  });

  @override
  State<ResumeTimerButton> createState() => _ResumeTimerButtonState();
}

class _ResumeTimerButtonState extends State<ResumeTimerButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("重启"),
      onPressed: () {
        widget.setTimerState(TimerState.started);
        widget.startCount();
      },
    );
  }
}
