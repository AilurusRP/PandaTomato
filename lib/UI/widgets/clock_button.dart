import 'package:flutter/material.dart';

import '../../utils/my_timer.dart';
import '../../utils/time_utils.dart';

class StartClockButton extends StatefulWidget {
  final Function setShowedTime;

  const StartClockButton({super.key, required this.setShowedTime});

  @override
  State<StartClockButton> createState() => _StartClockButtonState();
}

class _StartClockButtonState extends State<StartClockButton> {
  TextEditingController rawTimeStringInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
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
                                  MyTimer timer = MyTimer.getTimer(totalTime);
                                  timer.count((restTime) {
                                    widget.setShowedTime(restTime);
                                  });
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
            ),
          ],
        ),
      ),
    );
  }
}
