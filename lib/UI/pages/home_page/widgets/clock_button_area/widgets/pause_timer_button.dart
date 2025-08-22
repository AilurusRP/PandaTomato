import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class PauseTimerButton extends StatefulWidget {
  final Function(TimerState) setTimerState;

  const PauseTimerButton({super.key, required this.setTimerState});

  @override
  State<PauseTimerButton> createState() => _PauseTimerButtonState();
}

class _PauseTimerButtonState extends State<PauseTimerButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("暂停"),
      onPressed: () {
        widget.setTimerState(TimerState.paused);
      },
    );
  }
}
