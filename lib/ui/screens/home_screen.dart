import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/widgets/samurai_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SamuraiScaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => context.navigator.pushNamed("/creature"),
          child: Text(
            "Goh goh goh",
            style: context.theme.font.header.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
