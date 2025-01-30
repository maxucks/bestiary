import 'package:flutter/material.dart';

class ConstrainedTextPainter extends CustomPainter {
  ConstrainedTextPainter({
    required this.text,
    required this.style,
    this.maxLines = 4,
  });

  final String text;
  final TextStyle style;
  final int maxLines;

  @override
  void paint(Canvas canvas, Size size) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    );
    painter.layout(maxWidth: size.width);
    painter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
