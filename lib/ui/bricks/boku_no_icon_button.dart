import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoIconButton extends StatelessWidget {
  const BokuNoIconButton({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.color.bg.cover.secondary,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
