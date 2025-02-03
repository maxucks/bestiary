import 'package:bestiary/deps_provider_.dart';
import 'package:bestiary/modules/adapters/event_pipe.dart';
import 'package:bestiary/modules/adapters/fake_http.dart';
import 'package:bestiary/modules/blocs/paper_bloc.dart';
import 'package:bestiary/modules/blocs/papers_bloc.dart';
import 'package:bestiary/modules/repositories/rest_papers_repository.dart';
import 'package:bestiary/ui/screens/paper_screen.dart';
import 'package:bestiary/ui/screens/home_screen.dart';
import 'package:bestiary/ui/theme/app_theme.dart';
import 'package:bestiary/ui/theme/provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  EquatableConfig.stringify = true;
  final fakeHttp = FakeHttpAdapter();

  final papersRepo = RestPapersRepository(fakeHttp);

  final pipe = EventPipe();

  final papersBloc = PapersBloc(papersRepo, pipe);
  final paperBloc = PaperBloc(papersRepo, pipe);

  runApp(ThemeProvider(
    theme: LightAppTheme(),
    child: DependencyProvider(
      deps: Dependencies(
        pipe: pipe,
        httpClient: fakeHttp,
        papersRepository: papersRepo,
        paperBloc: paperBloc,
        papersBloc: papersBloc,
      ),
      child: BlocProvider.value(
        value: papersBloc,
        child: BlocProvider.value(
          value: paperBloc,
          child: const MyApp(),
        ),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (_) => HomeScreen(),
        "/paper": (_) => PaperScreen(),
      },
    );
  }
}
