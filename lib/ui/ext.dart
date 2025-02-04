import 'dart:math';

import 'package:bestiary/deps_provider_.dart';
import 'package:bestiary/ui/theme/provider.dart';
import 'package:bestiary/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

extension FontWeightExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);
}

extension ColorExtension on Color {
  static const _mute = 180;

  Color get muted => withBlue(b.toInt() + _mute).withGreen(g.toInt() + _mute).withRed(r.toInt() + _mute);
  Color get opaque => withAlpha(150);
}

extension ContextExtension on BuildContext {
  AppTheme get theme => ThemeProvider.of(this).theme;
  Dependencies get deps => DependencyProvider.of(this).deps;
  NavigatorState get navigator => Navigator.of(this);
}

extension ListExtension<T> on List<T> {
  T get random => this[Random().nextInt(length)];
}
