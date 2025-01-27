import 'package:bestiary/modules/blocs/books_bloc.dart';
import 'package:bestiary/modules/blocs/notifications_bloc.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:flutter/material.dart';

class Dependencies {
  Dependencies({
    required this.cacheClient,
    required this.httpClient,
    required this.booksRepository,
    required this.cacheBooksRepository,
    required this.booksBloc,
    required this.notificationsBloc,
  });

  final CacheAdapter cacheClient;
  final HttpAdapter httpClient;
  final BooksRepository booksRepository;
  final CacheBooksRepository cacheBooksRepository;
  final BooksBloc booksBloc;
  final NotificationsBloc notificationsBloc;
}

class DependencyProvider extends InheritedWidget {
  const DependencyProvider({
    super.key,
    required this.deps,
    required super.child,
  });

  final Dependencies deps;

  static DependencyProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }

  static DependencyProvider of(BuildContext context) {
    final DependencyProvider? result = maybeOf(context);
    assert(result != null, 'No DependencyProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) => deps != oldWidget.deps;
}
