import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.theme.color.bg.cover.secondary,
        ),
      ),
    );
  }
}
