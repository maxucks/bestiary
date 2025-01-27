import 'package:bestiary/models/books.dart';
import 'package:bestiary/ports/adapters.dart';

class FakeHttpAdapter implements HttpAdapter {
  final _fakeResponses = {
    '/books': <Map<String, dynamic>>[
      const BookModel(
        id: 1,
        title: 'Book #1',
        description: 'Anim ut aliqua labore cupidatat reprehenderit ipsum deserunt',
      ).toJson(),
      const BookModel(
        id: 2,
        title: 'Book #2',
        description: 'Dolor consequat aute ex proident',
      ).toJson(),
      const BookModel(
        id: 3,
        title: 'Book #3',
        description: 'Nulla voluptate ea eu cillum sunt sint duis velit fugiat ea qui sunt non',
      ).toJson(),
      const BookModel(
        id: 4,
        title: 'Book #4',
        description: 'Esse pariatur dolore commodo dolor anim id in duis Lorem mollit nostrud quis',
      ).toJson(),
    ],
  };

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _fakeResponses[path];
  }
}
