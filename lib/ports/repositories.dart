import 'package:bestiary/models/books.dart';

abstract interface class BooksRepository {
  Future<List<BookModel>> getBooks();
  Future<BookModel> getBook(int id);
}

abstract interface class CacheBooksRepository {
  Future<List<BookModel>> getBooks();
  Future<void> saveBooks(List<BookModel> books);
}
