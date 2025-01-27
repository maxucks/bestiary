import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ParallaxImage extends StatelessWidget {
  const ParallaxImage({
    super.key,
    required this.scrollPosition,
  });

  final ScrollPosition? scrollPosition;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset("assets/images/oni.png", fit: BoxFit.cover);

    return AspectRatio(
      aspectRatio: 4 / 6,
      child: scrollPosition != null
          ? Flow(
              delegate: _ParallaxFlowDelegate(scrollPosition: scrollPosition!),
              children: [
                image,
              ],
            )
          : image,
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  _ParallaxFlowDelegate({
    required this.scrollPosition,
  }) : super(repaint: scrollPosition);

  final ScrollPosition scrollPosition;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final dir = scrollPosition.pixels.sign >= 1.0 ? -1 : 1;
    final acceleration = clampDouble(scrollPosition.pixels.abs(), -600, 600) / 600;

    final offset = Offset(0.0, dir * (scrollPosition.pixels * 20 * acceleration / 100).abs());
    final transform = Transform.translate(offset: offset).transform;

    context.paintChild(0, transform: transform);
  }

  @override
  bool shouldRepaint(_ParallaxFlowDelegate oldDelegate) {
    return scrollPosition != oldDelegate.scrollPosition;
  }
}
