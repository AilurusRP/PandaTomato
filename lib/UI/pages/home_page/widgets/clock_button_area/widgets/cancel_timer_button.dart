import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class CancelTimerButton extends StatefulWidget {
  final Function(TimerState) setTimerState;

  const CancelTimerButton({super.key, required this.setTimerState});

  @override
  State<CancelTimerButton> createState() => _CancelTimerButtonState();
}

class _CancelTimerButtonState extends State<CancelTimerButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(child: Text("取消"), onPressed: () {
      widget.setTimerState(TimerState.beforeStart);
    });
  }
}
