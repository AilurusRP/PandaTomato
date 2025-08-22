import 'package:flutter/material.dart';
import '../../../utils/time_utils.dart';
import '../../../utils/timer_state.dart';

class StartTimerButton extends StatefulWidget {
  final void Function(int) setShowedTime;
  final Function(TimerState) setTimerState;
  final Function(int) setTime;
  final VoidCallback count;

  const StartTimerButton({
    super.key,
    required this.setShowedTime,
    required this.setTimerState,
    required this.setTime,
    required this.count,
  });

  @override
  State<StartTimerButton> createState() => _StartTimerButtonState();
}

class _StartTimerButtonState extends State<StartTimerButton> {
  TextEditingController rawTimeStringInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 128),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("请输入时间"),
                      Container(
                        height: 50,
                        width: 150,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: rawTimeStringInputController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints(maxHeight: 40),
                    margin: EdgeInsets.all(10),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (checkTimeInput(
                              context,
                              rawTimeStringInputController,
                            ) ==
                            InputTimeState.correctInput) {
                          int totalTime = getTime(
                            rawTimeStringInputController.text,
                          );
                          widget.setShowedTime(totalTime);
                          widget.setTime(totalTime);
                          widget.count();
                          widget.setTimerState(TimerState.started);
                        }
                        rawTimeStringInputController.clear();
                      },
                      child: Text("确定"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Text("计时"),
    );
  }
}
