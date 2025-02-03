import 'package:bestiary/ports/adapters.dart';

class BussinCache implements CacheAdapter {
  final Map<String, dynamic> _cache = {};
  final int cacheTime;

  BussinCache({required this.cacheTime});

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
