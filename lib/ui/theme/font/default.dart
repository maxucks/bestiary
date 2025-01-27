import 'package:bestiary/ui/theme/font/typeface_theme.dart';
import 'package:flutter/material.dart';

class DefaultTypeface implements TypefaceTheme {
  DefaultTypeface()
      : header = _defaultTextStyle.copyWith(
          fontSize: 30.08,
        ),
        subtitle = _defaultTextStyle.copyWith(
          fontSize: 19.25,
        ),
        body = _defaultTextStyle.copyWith(
          fontSize: 15.4,
        ),
        dropCap = _defaultTextStyle.copyWith(
          fontSize: 80,
          height: 1.1,
          letterSpacing: 0,
        );

  static const _defaultTextStyle = TextStyle(
    fontFamily: "LXGW WenKai TC",
    height: 1.4,
    leadingDistribution: TextLeadingDistribution.proportional,
    letterSpacing: -0.2,
    fontWeight: FontWeight.bold,
  );

  @override
  final TextStyle header;

  @override
  final TextStyle subtitle;

  @override
  final TextStyle body;

  @override
  final TextStyle dropCap;
}
