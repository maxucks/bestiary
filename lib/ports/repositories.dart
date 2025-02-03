import 'package:bestiary/models/paper.dart';
import 'package:bestiary/models/short_paper.dart';

abstract interface class PapersRepository {
  Future<List<ShortPaper>> getPapers(int categoryId);
  Future<Paper> getPaper(int id);
}

// abstract interface class CacheBooksRepository {
//   Future<List<BookModel>> getBooks();
//   Future<void> saveBooks(List<BookModel> books);
// }
