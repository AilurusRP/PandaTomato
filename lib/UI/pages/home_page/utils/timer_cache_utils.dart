import 'package:shared_preferences/shared_preferences.dart';

class TimerCacheUtils {
  SharedPreferencesWithCache? _prefs;

  TimerCacheUtils._create(){}

  static Future<TimerCacheUtils> create() async {
    var timerCacheUtilsInstance = TimerCacheUtils._create();
    timerCacheUtilsInstance._prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    return timerCacheUtilsInstance;
  }

  Future<void> setInitialTimestampCache(int timestamp) async {
    _prefs!.setInt("initialTimestamp", timestamp);
  }

  Future<void> setRestTimeCache(int restTime) async {
    _prefs!.setInt("restTime", restTime);
  }

  Future<void> setPausedCache(bool paused) async {
    _prefs!.setBool("paused", paused);
  }

  Future<int?> getInitialTimestampCache() async {
    return _prefs!.getInt("initialTimestamp");
  }

  Future<int?> getRestTimeCache() async {
    return _prefs!.getInt("restTime");
  }

  Future<bool?> getPausedCache() async {
    return _prefs!.getBool("paused");
  }

  Future<void> clearCache() async {
    _prefs!.clear();
  }
}
