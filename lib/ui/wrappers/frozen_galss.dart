import 'dart:ui';

import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class FrozenGalss extends StatelessWidget {
  const FrozenGalss({
    super.key,
    required this.child,
  });

  final Widget child;

  static const double _blur = 4.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: context.theme.color.effect.frozenGlassColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}
