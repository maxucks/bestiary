import 'package:flutter/material.dart';

class SamuraiScaffold extends StatelessWidget {
  const SamuraiScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292423),
      body: body,
    );
  }
}
