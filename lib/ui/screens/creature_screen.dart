import 'dart:async';

import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/widgets/parallax_image.dart';
import 'package:flutter/material.dart';

const text =
    "Один из самых известных и популярных видов цукумогами. Как и большинство других цукумогами, каса-обаке появился на свет, скорее всего, в эпоху Эдо благодаря художникам-иллюстраторам, потому что японский народный фольклор не знает никаких сказок, легенд или быличек про это существо. Зато картинок, иллюстраций, манга и аниме с участием каса-обакэ просто не перечесть. Причиной тому — добродушный характер каракаса-обакэ и его запоминающийся облик: подпрыгивающий на одной ноге старый бумажный зонтик с одним глазом и длинным высунутым языком. Это классический облик, придуманный Сигэру Мидзуки. До него облик каса-обакэ был более вариативен — иногда добавлялись две руки, или говорили о его двух глазах, двух ногах.\n\nКак говорится в одной сказке, в большом старом особняке провели тщательную уборку и выкинули множество утвари, которая показалась старой или слишком обычной. Эти предметы, к которым относились посуда, кухонная туварь и даже старая мебель, собрались вместе и составили план по запугиванию обитателей особняка, за то, что те пренебрегли ими.\n\nТакие ожившие предметы выступают в качестве параллели с западным полтергейстом. Их легко обидеть, и, если хозяева будут не достаточно заботиться, то цукумогами могут что-нибудь разбить или сломать.";

class CreatureScreen extends StatefulWidget {
  const CreatureScreen({
    super.key,
  });

  static const _borderRadius = Radius.circular(50);

  @override
  State<CreatureScreen> createState() => _CreatureScreenState();
}

class _CreatureScreenState extends State<CreatureScreen> {
  late final ScrollController _scrollController;

  final _scrollPositionController = StreamController<ScrollPosition>();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(
      onAttach: (position) {
        _scrollPositionController.add(position);
      },
    );
  }

  // Returns len of the substring fitting within the passed constraints
  int fitText(BoxConstraints constraints, String text, TextStyle style, {int maxLines = 4}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StreamBuilder(
              stream: _scrollPositionController.stream,
              builder: (_, snapshot) => ParallaxImage(scrollPosition: snapshot.data),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 1.5 - 50),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: CreatureScreen._borderRadius,
                      topRight: CreatureScreen._borderRadius,
                    ),
                    boxShadow: context.theme.color.effect.shadow,
                    color: context.theme.color.bg.primary,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 50),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Каса-обакэ",
                            style: context.theme.font.header.copyWith(color: context.theme.color.fg.body),
                          ),
                          const SizedBox(height: 0),
                          Text(
                            "からかさ小僧",
                            style: context.theme.font.subtitle.copyWith(color: context.theme.color.fg.body.muted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(color: context.theme.color.bg.secondary),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: LayoutBuilder(builder: (context, constraints) {
                          final dropCap = text[0];
                          final content = text.substring(1);

                          final bodyStyle = context.theme.font.body.copyWith(
                            color: context.theme.color.fg.body,
                          );
                          final dropCapStyle = context.theme.font.dropCap.copyWith(
                            color: context.theme.color.fg.dropCap,
                          );

                          // TODO: refactor
                          final painter = TextPainter(
                            text: TextSpan(text: dropCap, style: dropCapStyle),
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                          );
                          painter.layout(maxWidth: constraints.maxWidth);

                          const dropCapGap = 16.0;
                          final dropCapWidth = painter.width + dropCapGap;

                          final fitConstraints = BoxConstraints(maxWidth: constraints.maxWidth - dropCapWidth);
                          final fitLen = fitText(fitConstraints, content, context.theme.font.body);
                          final upperText = content.substring(0, fitLen);
                          final lowerText = content.substring(fitLen);

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(dropCap, style: dropCapStyle),
                                  const SizedBox(width: dropCapGap),
                                  Expanded(
                                    child: CustomPaint(
                                      size: Size.fromHeight(dropCapStyle.fontSize! * dropCapStyle.height!),
                                      painter: ConstrainedTextPainter(
                                        // IMA HACKER!!
                                        // TODO: refactor
                                        text: upperText + lowerText.substring(0, 15),
                                        style: bodyStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(lowerText, style: bodyStyle, textAlign: TextAlign.justify),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
