import 'package:flutter/material.dart';
import '../../../utils/timer_state.dart';

class CancelTimerButton extends StatefulWidget {
  final VoidCallback cancel;

  const CancelTimerButton({super.key, required this.cancel});

  @override
  State<CancelTimerButton> createState() => _CancelTimerButtonState();
}

class _CancelTimerButtonState extends State<CancelTimerButton> {
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
                            widget.cancel();
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
