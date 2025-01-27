import 'package:bestiary/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  final AppTheme theme;

  static ThemeProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result = maybeOf(context);
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) => theme != oldWidget.theme;
}
