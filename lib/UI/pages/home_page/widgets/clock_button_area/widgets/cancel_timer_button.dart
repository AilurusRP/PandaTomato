import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class CancelTimerButton extends StatelessWidget {
  final VoidCallback cancelTimer;

  const CancelTimerButton({super.key, required this.cancelTimer});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("取消"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 75),
                child: Column(
                  children: [
                    Text("确定要取消计时吗？"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            cancelTimer();
                            Navigator.pop(context);
                          },
                          child: Text("确定"),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("点错了"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
