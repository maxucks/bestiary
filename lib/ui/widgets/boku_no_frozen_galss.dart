import 'dart:ui';

import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoFrozenGalss extends StatelessWidget {
  const BokuNoFrozenGalss({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.theme.color.bg.cover.primary.opaque,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: child,
      ),
    );
  }
}
