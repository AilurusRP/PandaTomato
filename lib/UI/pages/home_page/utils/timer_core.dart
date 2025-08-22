class TimerCore {
  static TimerCore? _instance;

  TimerCore._internal(this._time);

  static getTimer(int time) {
    _instance = TimerCore._internal(time);
    return _instance;
  }

  int _time;
  bool _isPaused = false;

  pause() {
    _isPaused = true;
  }

  count(void Function(int) callback) async {
    while (_time > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (!identical(this, _instance)) return;
      if (_isPaused) return;

      _time--;
      callback(_time);
    }
  }
}
