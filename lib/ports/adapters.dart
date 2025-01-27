import 'package:bestiary/events/pipe_event.dart';

abstract interface class Pipe {
  Stream<PipeEvent> stream();
  void publish(PipeEvent event);
}

abstract interface class HttpAdapter {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
}

abstract interface class CacheAdapter {
  Future<T> get<T>(String key);
  Future<void> set(String key, dynamic value);
}
