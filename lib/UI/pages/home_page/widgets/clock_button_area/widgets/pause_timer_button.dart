import 'package:flutter/material.dart';
import 'package:panda_tomato/UI/pages/home_page/utils/timer_cache_utils.dart';
import '../../../utils/timer_state.dart';

class PauseTimerButton extends StatelessWidget {
  final Function(TimerState) setTimerState;

  final int timeCount;

  const PauseTimerButton({
    super.key,
    required this.setTimerState,
    required this.timeCount,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text("暂停"),
      onPressed: () async {
        var timerCache = TimerCacheUtils();
        timerCache.setPausedCache(true);
        timerCache.setRestTimeCache(timeCount);
        setTimerState(TimerState.paused);
      },
    );
  }
}
