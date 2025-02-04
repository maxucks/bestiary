import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class ListOfPaper extends StatelessWidget {
  const ListOfPaper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  static const _borderRadius = Radius.circular(20);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: _borderRadius, topRight: _borderRadius),
          boxShadow: context.theme.color.effect.shadow,
          color: context.theme.color.bg.primary,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}
