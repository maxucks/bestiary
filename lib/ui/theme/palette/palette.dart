import 'package:flutter/material.dart';

abstract interface class Palette {
  BackgroundPalette get bg;
  ForegroundPalette get fg;
  EffectsPalette get effect;
}

abstract interface class BackgroundPalette {
  Color get primary;
  Color get secondary;
}

abstract interface class ForegroundPalette {
  Color get quote;
  Color get body;
  Color get dropCap;
}

abstract interface class EffectsPalette {
  List<BoxShadow> get shadow;
}
