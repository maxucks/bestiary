import 'package:bestiary/models/creature.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/widgets/boku_no_frozen_galss.dart';
import 'package:flutter/material.dart';

class CreatureCard extends StatelessWidget {
  const CreatureCard({
    super.key,
    required this.creature,
    this.aspectRatio = 0.8,
    this.onTap,
  });

  final ListCreature creature;
  final double aspectRatio;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/oni.png"),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 12,
            right: 12,
            child: BokuNoFrozenGalss(
              child: Text(
                creature.name.local,
                textAlign: TextAlign.center,
                style: context.theme.font.subtitle.copyWith(
                  color: context.theme.color.fg.cover.active,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
