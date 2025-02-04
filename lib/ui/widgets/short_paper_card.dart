import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/wrappers/frozen_galss.dart';
import 'package:bestiary/ui/bricks/shimmer.dart';
import 'package:bestiary/ui/wrappers/shimmer_switcher.dart';
import 'package:flutter/material.dart';

class ShortPaperCard extends StatelessWidget {
  const ShortPaperCard({
    super.key,
    required this.paper,
    this.onTap,
    this.aspectRatio = 0.8,
  });

  final ShortPaper? paper;
  final double aspectRatio;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    if (paper == null) {
      child = AspectRatio(aspectRatio: aspectRatio, child: Shimmer());
    } else {
      final data = paper!;

      child = GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(const Color.fromARGB(255, 167, 145, 131), BlendMode.overlay),
                    image: AssetImage(data.imageUrl),
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
              child: FrozenGalss(
                child: Text(
                  data.title,
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

    return ShimmerSwitcher(child: child);
  }
}
