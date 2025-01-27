import 'package:bestiary/ports/adapters.dart';
import 'package:dio/dio.dart';

class DioAdapter implements HttpAdapter {
  final Dio _client;

  DioAdapter(String baseUrl)
      : _client = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 3),
        ));

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final res = await _client.get(path, queryParameters: queryParameters);
    return res.data;
  }
}
