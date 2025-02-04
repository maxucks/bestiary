import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoBackButton extends StatelessWidget {
  const BokuNoBackButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 48,
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: context.theme.color.effect.shadow,
            shape: BoxShape.circle,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: context.theme.color.bg.cover.primary,
            ),
          ),
        ),
      ),
    );
  }
}
