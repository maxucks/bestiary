import 'package:bestiary/ui/screens/creature_screen.dart';
import 'package:bestiary/ui/theme/app_theme.dart';
import 'package:bestiary/ui/theme/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: LightAppTheme(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CreatureScreen(),
      ),
    );
  }
}
