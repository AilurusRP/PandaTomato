import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class ResumeTimerButton extends StatefulWidget {
  final Function(TimerState) setTimerState;

  const ResumeTimerButton({super.key, required this.setTimerState});

  @override
  State<ResumeTimerButton> createState() => _ResumeTimerButtonState();
}

class _ResumeTimerButtonState extends State<ResumeTimerButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(child: Text("重启"), onPressed: () {
      widget.setTimerState(TimerState.started);
    });
  }
}
