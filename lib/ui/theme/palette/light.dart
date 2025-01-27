import 'package:bestiary/ui/theme/palette/palette.dart';
import 'package:flutter/material.dart';

class LightPalette implements Palette {
  @override
  final BackgroundPalette bg = LightBackgroundPalette();
  @override
  final ForegroundPalette fg = LightForegroundPalette();
  @override
  final EffectsPalette effect = LightEffectsPalette();
}

class LightBackgroundPalette implements BackgroundPalette {
  @override
  final Color primary = Color(0xFFF6F3EC);
  @override
  final Color secondary = Color(0xFFEEECE6);
}

class LightForegroundPalette implements ForegroundPalette {
  @override
  final Color quote = Color(0xFF83746A);
  @override
  final Color body = Color(0xFF383838);
  @override
  final Color dropCap = Color(0xFFEF6161);
}

class LightEffectsPalette implements EffectsPalette {
  @override
  final shadow = [
    BoxShadow(
      color: Colors.black.withAlpha(100),
      blurRadius: 50,
      spreadRadius: 16,
    ),
  ];
}
