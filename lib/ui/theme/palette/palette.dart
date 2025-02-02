import 'package:flutter/material.dart';

abstract interface class Palette {
  BackgroundPalette get bg;
  ForegroundPalette get fg;
  AccentPalette get accent;
  EffectsPalette get effect;
}

abstract interface class BackgroundPalette {
  Color get primary;
  Color get secondary;
  CoverBackgroundPalette get cover;
}

abstract interface class ForegroundPalette {
  Color get quote;
  Color get body;
  Color get dropCap;
  CoverForegroundPalette get cover;
}

abstract interface class CoverBackgroundPalette {
  Color get primary;
  Color get secondary;
}

abstract interface class CoverForegroundPalette {
  Color get body;
  Color get hint;
  Color get active;
}

abstract interface class AccentPalette {
  Color get star;
}

abstract interface class EffectsPalette {
  List<BoxShadow> get shadow;
}
