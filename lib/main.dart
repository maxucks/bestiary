import 'package:bestiary/deps_provider_.dart';
import 'package:bestiary/modules/adapters/event_pipe.dart';
import 'package:bestiary/modules/blocs/creature_bloc.dart';
import 'package:bestiary/ui/screens/creature_screen.dart';
import 'package:bestiary/ui/screens/home_screen.dart';
import 'package:bestiary/ui/theme/app_theme.dart';
import 'package:bestiary/ui/theme/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final pipe = EventPipe();
  final creaturesBloc = CreatureBloc(pipe);

  runApp(ThemeProvider(
    theme: LightAppTheme(),
    child: DependencyProvider(
      deps: Dependencies(
        pipe: pipe,
        creatureBloc: creaturesBloc,
      ),
      child: BlocProvider.value(
        value: creaturesBloc,
        child: const MyApp(),
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
        "/creature": (_) => CreatureScreen(),
      },
    );
  }
}
