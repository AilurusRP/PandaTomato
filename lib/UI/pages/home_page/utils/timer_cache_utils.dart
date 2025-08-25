import 'package:shared_preferences/shared_preferences.dart';

class TimerCacheUtils {
  SharedPreferencesWithCache? _prefs;

  Future<void> setInitialTimestampCache(int timestamp) async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    _prefs!.setInt("initialTimestamp", timestamp);
  }

  Future<void> setRestTimeCache(int restTime) async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    _prefs!.setInt("restTime", restTime);
  }

  Future<void> setPausedCache(bool paused) async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    _prefs!.setBool("paused", paused);
  }

  Future<int?> getInitialTimestampCache() async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    return _prefs!.getInt("initialTimestamp");
  }

  Future<int?> getRestTimeCache() async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    return _prefs!.getInt("restTime");
  }

  Future<bool?> getPausedCache() async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    return _prefs!.getBool("paused");
  }

  Future<void> clearCache() async {
    _prefs ??= await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    _prefs!.clear();
  }
}
