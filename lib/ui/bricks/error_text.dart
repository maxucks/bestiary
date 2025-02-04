import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.theme.font.subtitle.copyWith(
        color: context.theme.color.fg.cover.body,
      ),
      textAlign: TextAlign.center,
    );
  }
}
