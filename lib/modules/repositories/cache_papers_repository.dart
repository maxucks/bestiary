// TODO: there are no so many changes in content, so it makes sence to cache all the content once it is downloaded, and
// invalidate it only after some huge timespan, or when user refresh the page manually

// import 'package:bestiary/models/books.dart';
// import 'package:bestiary/ports/adapters.dart';
// import 'package:bestiary/ports/repositories.dart';

// class BooksCache implements CacheBooksRepository {
//   final CacheAdapter _cache;

//   static const _booksKey = "books";

//   const BooksCache(this._cache);

//   @override
//   Future<List<BookModel>> getBooks() async {
//     return await _cache.get<List<BookModel>>(_booksKey);
//   }

//   @override
//   Future<void> saveBooks(List<BookModel> books) async {
//     return _cache.set(_booksKey, books);
//   }
// }
