import 'package:bestiary/models/books.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';

class RestBooksRepository implements BooksRepository {
  static const _endpoint = "/books";

  final HttpAdapter source;

  const RestBooksRepository(this.source);

  @override
  Future<List<BookModel>> getBooks() async {
    final rawBooks = await source.get(_endpoint) as List<Map<String, dynamic>>;
    final books = rawBooks.map(BookModel.fromJson);
    return books.toList();
  }

  @override
  Future<BookModel> getBook(int id) async {
    final rawBook = await source.get('$_endpoint/$id');
    final book = BookModel.fromJson(rawBook);
    return book;
  }
}
