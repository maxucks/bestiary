part of 'paper_screen.dart';

class _PaperText {
  _PaperText({
    required this.dropCap,
    required this.dropCapStyle,
    required this.dropCapText,
    required this.bodyText,
    required this.style,
  });

  final String dropCap;
  final String dropCapText;
  final String bodyText;
  final TextStyle dropCapStyle;
  final TextStyle style;
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
  });

  final String description;

  static const double _dropCapGap = 16.0;

  // TODO: reduce count of iterations using euristic (presumably 10 first words always fit)
  // If text fits constraints, returns index of the last fitted char
  int fitIn(String text, BoxConstraints constraints, TextStyle style, {int maxLines = 4}) {
    final words = text.split(" ");
    String currentText = words[0];

    for (int i = 1; i < words.length; i++, currentText = "$currentText ${words[i]}") {
      final painter = TextPainter(
        text: TextSpan(text: currentText, style: style),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        maxLines: maxLines,
      );

      painter.layout(maxWidth: constraints.maxWidth);
      if (painter.didExceedMaxLines) {
        return words.sublist(0, i).join(" ").length;
      }
    }

    return text.length;
  }

  double getDropCapWidth(BoxConstraints constraints, String dropCap, TextStyle dropCapStyle) {
    final painter = TextPainter(
      text: TextSpan(text: dropCap, style: dropCapStyle),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: constraints.maxWidth);

    return painter.width + _dropCapGap;
  }

  _PaperText getPaperText(BuildContext context, BoxConstraints constraints) {
    final bodyStyle = context.theme.font.body.copyWith(color: context.theme.color.fg.body);
    final dropCapStyle = context.theme.font.dropCap.copyWith(color: context.theme.color.fg.dropCap);

    final dropCap = description[0];
    final text = description.substring(1);

    final dropCapWidth = getDropCapWidth(constraints, dropCap, dropCapStyle);
    final spaceOnTheRight = BoxConstraints(maxWidth: constraints.maxWidth - dropCapWidth);
    final lastFitted = fitIn(text, spaceOnTheRight, bodyStyle);

    return _PaperText(
      dropCap: dropCap,
      dropCapText: text.substring(0, lastFitted),
      bodyText: text.substring(lastFitted),
      dropCapStyle: dropCapStyle,
      style: bodyStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: LayoutBuilder(builder: (context, constraints) {
        final paperText = getPaperText(context, constraints);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DropCapText(text: paperText, gap: _dropCapGap),
            Text(paperText.bodyText, style: paperText.style, textAlign: TextAlign.justify),
          ],
        );
      }),
    );
  }
}

class _DropCapText extends StatelessWidget {
  const _DropCapText({
    required this.text,
    required this.gap,
  });

  final _PaperText text;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text.dropCap, style: text.dropCapStyle),
        SizedBox(width: gap),
        Expanded(
          child: CustomPaint(
            size: Size.fromHeight(text.dropCapStyle.fontSize! * text.dropCapStyle.height!),
            // IMA HACKER!!
            // This need to stretch last line of paragraph by hiding the next line
            painter: MaxLinesTextPainter(
              text: text.dropCapText + text.bodyText.substring(0, 15),
              style: text.style,
            ),
          ),
        )
      ],
    );
  }
}
