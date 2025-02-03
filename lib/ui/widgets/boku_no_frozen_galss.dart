import 'dart:ui';

import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoFrozenGalss extends StatelessWidget {
  const BokuNoFrozenGalss({
    super.key,
    required this.child,
  });

  final Widget child;

  static const double _blur = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.theme.color.effect.frozenGlassColor,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: child,
      ),
    );
  }
}
