import 'package:bestiary/ports/adapters.dart';

class SimpleCache implements CacheAdapter {
  final Map<String, dynamic> _cache = {};
  final int cacheTime;

  SimpleCache({required this.cacheTime});

  @override
  Future<T> get<T>(String key) async {
    return _cache[key] as T;
  }

  @override
  Future<void> set(String key, dynamic value) async {
    _cache[key] = value;
    Future.delayed(Duration(seconds: cacheTime), () {
      _cache.remove(key);
    });
  }
}
