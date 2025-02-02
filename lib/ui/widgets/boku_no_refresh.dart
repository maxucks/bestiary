import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoRefresh extends StatelessWidget {
  const BokuNoRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: context.theme.color.bg.primary,
      color: context.theme.color.accent.star,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
