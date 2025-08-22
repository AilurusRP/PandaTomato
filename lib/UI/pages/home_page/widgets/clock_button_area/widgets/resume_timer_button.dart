import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class ResumeTimerButton extends StatefulWidget {
  final Function(TimerState) setTimerState;

  final VoidCallback count;

  const ResumeTimerButton({
    super.key,
    required this.setTimerState,
    required this.count,
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
        widget.count();
      },
    );
  }
}
