import 'package:bestiary/ui/theme/palette/palette.dart';
import 'package:flutter/material.dart';

class LightPalette implements Palette {
  @override
  final BackgroundPalette bg = LightBackgroundPalette();
  @override
  final ForegroundPalette fg = LightForegroundPalette();
  @override
  final LightAccentPalette accent = LightAccentPalette();
  @override
  final EffectsPalette effect = LightEffectsPalette();
}

class LightBackgroundPalette implements BackgroundPalette {
  @override
  final Color primary = Color(0xFFF6F3EC);
  @override
  final Color secondary = Color(0xFFEEECE6);
  @override
  final CoverBackgroundPalette cover = LightCoverBackgroundPalette();
}

class LightForegroundPalette implements ForegroundPalette {
  @override
  final Color quote = Color(0xFF83746A);
  @override
  final Color body = Color(0xFF383838);
  @override
  final Color dropCap = Color(0xFFEF6161);
  @override
  final CoverForegroundPalette cover = LightCoverForegroundPalette();
}

class LightCoverBackgroundPalette implements CoverBackgroundPalette {
  @override
  final Color primary = Color(0xFF292423);
  @override
  final Color secondary = Color(0x7E4F4543);
}

class LightCoverForegroundPalette implements CoverForegroundPalette {
  @override
  final Color body = Color(0xFFAA9A90);
  @override
  final Color hint = Color(0xFF746664);
  @override
  final Color active = Color(0xFFFCFCFC);
}

class LightAccentPalette implements AccentPalette {
  @override
  final Color star = Color(0xFFEFC261);
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
