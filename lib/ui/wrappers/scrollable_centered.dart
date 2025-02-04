import 'package:bestiary/ui/wrappers/boku_no_refresh.dart';
import 'package:flutter/material.dart';

class ScrollableCentered extends StatelessWidget {
  const ScrollableCentered({
    super.key,
    this.onRefresh,
    required this.child,
  });

  final Future<void> Function()? onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final content = SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Center(child: child),
          ),
        );

        if (onRefresh != null) {
          return BokuNoRefresh(
            onRefresh: onRefresh!,
            child: content,
          );
        }

        return content;
      },
    );
  }
}
