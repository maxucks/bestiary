import 'package:bestiary/ui/theme/font/default.dart';
import 'package:bestiary/ui/theme/font/typeface_theme.dart';
import 'package:bestiary/ui/theme/palette/light.dart';
import 'package:bestiary/ui/theme/palette/palette.dart';

abstract interface class AppTheme {
  Palette get color;
  TypefaceTheme get font;
}

class LightAppTheme implements AppTheme {
  @override
  final Palette color = LightPalette();

  @override
  final TypefaceTheme font = DefaultTypeface();
}
