// import 'dart:async';

// import 'package:bestiary/deps_provider_.dart';
// import 'package:bestiary/events/popup_event.dart';
// import 'package:bestiary/models/books.dart';
// import 'package:bestiary/modules/blocs/books_bloc.dart';
// import 'package:bestiary/modules/blocs/state.dart';
// import 'package:bestiary/ui/widgets/book.dart';
// import 'package:bestiary/ui/widgets/snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BooksScreen extends StatefulWidget {
//   const BooksScreen({
//     super.key,
//   });

//   @override
//   State<BooksScreen> createState() => _BooksScreenState();
// }

// class _BooksScreenState extends State<BooksScreen> {
//   late final StreamSubscription<PopupEvent> sub;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final stream = DependencyProvider.of(context).deps.notificationsBloc.popupStream;
//     sub = stream.listen(_onPopupEvent);

//     _loadBooks();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     sub.cancel();
//   }

//   Future<void> _loadBooks() async {
//     final books = DependencyProvider.of(context).deps.booksBloc;
//     books.add(FetchBooksEvent());
//   }

//   void _onPopupEvent(PopupEvent event) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: EventPopupMessage(title: event.title, message: event.message),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: _loadBooks,
//       child: Center(
//         child: BlocBuilder<BooksBloc, BlocState<List<BookModel>>>(
//           builder: (context, state) => switch (state.status) {
//             Status.pending => const CircularProgressIndicator(color: Colors.amber),
//             Status.error => Text(state.error!),
//             Status.done => ListView.separated(
//                 itemCount: state.value!.length,
//                 separatorBuilder: (context, index) => const SizedBox(height: 8),
//                 itemBuilder: (context, index) {
//                   final book = state.value![index];
//                   return Book(
//                     id: book.id,
//                     title: book.title,
//                     description: book.description,
//                   );
//                 },
//               ),
//             _ => const Text("Idle")
//           },
//         ),
//       ),
//     );
//   }
// }
