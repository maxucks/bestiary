// import 'package:bestiary/events/pipe_event.dart';
// import 'package:bestiary/models/books.dart';
// import 'package:bestiary/modules/blocs/state.dart';
// import 'package:bestiary/ports/adapters.dart';
// import 'package:bestiary/ports/repositories.dart';
// import 'package:bloc/bloc.dart';

// abstract class BooksEvent {}

// class FetchBooksEvent extends BooksEvent {}

// class FetchBookEvent extends BooksEvent {}

// class BooksBloc extends Bloc<BooksEvent, BlocState<List<BookModel>>> {
//   final BooksRepository _books;
//   final CacheBooksRepository _cache;
//   final Pipe _pipe;

//   BooksBloc(this._books, this._cache, this._pipe) : super(BlocState.idle()) {
//     on<FetchBooksEvent>(_loadBooks);
//   }

//   Future<void> _loadBooks(FetchBooksEvent event, Emitter<BlocState<List<BookModel>>> emit) async {
//     try {
//       emit(BlocState.pending(value: state.value));

//       List<BookModel> books;

//       try {
//         books = await _cache.getBooks();
//       } catch (_) {
//         final res = await _books.getBooks();
//         _cache.saveBooks(res);
//         books = res;

//         _pipe.publish(BooksCachedPipeEvent());
//       }

//       emit(BlocState.done(books as List<BookModel>?));
//     } catch (e) {
//       emit(BlocState.error(e.toString()));
//     }
//   }
// }
