import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoScaffold extends StatelessWidget {
  const BokuNoScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.color.bg.cover.primary,
      body: body,
    );
  }
}
