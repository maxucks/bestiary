import 'package:flutter/material.dart';

class ShimmerSwitcher extends StatelessWidget {
  const ShimmerSwitcher({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeInOutSine,
      switchOutCurve: Curves.easeInOutSine,
      child: child,
    );
  }
}
