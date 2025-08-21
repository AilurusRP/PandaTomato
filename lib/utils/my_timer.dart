class MyTimer {
  static MyTimer? _instance;

  MyTimer._internal(this._time);

  static getTimer(int time) {
    _instance = MyTimer._internal(time);
    return _instance;
  }

  int _time;

  count(Function(int) callback) async {
    while (_time > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (!identical(this, _instance)) return;

      _time--;
      callback(_time);
    }
  }
}
