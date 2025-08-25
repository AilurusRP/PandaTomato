import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/utils/timer_cache_utils.dart';
import '../../../utils/timer_state.dart';

class ResumeTimerButton extends StatelessWidget {
  final Function(TimerState) setTimerState;

  final Future<void> Function() startCount;

  const ResumeTimerButton({
    super.key,
    required this.setTimerState,
    required this.startCount,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("重启"),
      onPressed: () {
        var timerCache = TimerCacheUtils();
        timerCache.setPausedCache(false);
        timerCache.setInitialTimestampCache(
          DateTime.now().millisecondsSinceEpoch,
        );
        setTimerState(TimerState.started);
        startCount();
      },
    );
  }
}
