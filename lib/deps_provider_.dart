import 'package:bestiary/modules/adapters/event_pipe.dart';
import 'package:bestiary/modules/blocs/paper_bloc.dart';
import 'package:bestiary/modules/blocs/papers_bloc.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:flutter/material.dart';

class Dependencies {
  Dependencies({
    required this.pipe,
    required this.httpClient,
    required this.papersRepository,
    required this.paperBloc,
    required this.papersBloc,
  });

  final EventPipe pipe;

  final HttpAdapter httpClient;

  final PapersRepository papersRepository;

  final PaperBloc paperBloc;
  final PapersBloc papersBloc;
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
