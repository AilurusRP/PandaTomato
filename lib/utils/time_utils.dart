import 'package:flutter/material.dart';

int getTime(String rawTimeString) {
  List<int> timeLst = rawTimeString
      .split(":")
      .map<int>((item) => int.parse(item))
      .toList();

  return timeLst.reduce((val, com) => 60 * val + com);
}

String toShowedTime(int time) {
  int seconds = time % 60;
  int minutes = time % 3600 ~/ 60;
  int hours = time ~/ 3600;

  String secStr = seconds >= 10 ? seconds.toString() : "0$seconds";
  String minStr = minutes >= 10 ? minutes.toString() : "0$minutes";
  String hrStr = hours.toString();

  return "$hrStr:$minStr:$secStr";
}

InputTimeState checkTimeInput(
  BuildContext context,
  TextEditingController? controller,
) {
  if (controller == null) {
    showAlertDialog(context, InputTimeState.timeControllerIsNull);
    return InputTimeState.timeControllerIsNull;
  } else if (controller.text.isEmpty) {
    showAlertDialog(context, InputTimeState.inputIsEmpty);
    return InputTimeState.inputIsEmpty;
  } else if (!controller.text.contains(RegExp(r"^[0-9:]+$")) ||
      controller.text.split(":").length > 3 ||
      controller.text
          .split(":")
          .any((item) => int.parse(item) >= 60 || int.parse(item) < 0)) {
    // 时间只能为 n:nn:nn 或 nn:nn 或 nn 的格式
    showAlertDialog(context, InputTimeState.wrongTimeFormat);
    return InputTimeState.wrongTimeFormat;
  } else {
    return InputTimeState.correctInput;
  }
}

showAlertDialog(BuildContext context, InputTimeState state) {
  String text = switch (state) {
    InputTimeState.timeControllerIsNull => "未知错误：_timeController为null",
    InputTimeState.inputIsEmpty => "时间不能为空！",
    InputTimeState.wrongTimeFormat => "时间格式错误！",
    InputTimeState.correctInput => throw AssertionError(
      "InputTimeState.correctInput 的情况不应使用 showAlertDialog",
    ),
  };

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(content: Text(text));
    },
  );
}

enum InputTimeState {
  timeControllerIsNull,
  inputIsEmpty,
  wrongTimeFormat,
  correctInput,
}
