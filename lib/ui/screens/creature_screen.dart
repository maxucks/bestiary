import 'dart:async';

import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/creature.dart';
import 'package:bestiary/modules/blocs/creature_bloc.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/painters/constrained_text_painter.dart';
import 'package:bestiary/ui/widgets/parallax_image.dart';
import 'package:bestiary/ui/widgets/boku_no_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatureScreen extends StatefulWidget {
  const CreatureScreen({
    super.key,
  });

  static const _borderRadius = Radius.circular(50);

  @override
  State<CreatureScreen> createState() => _CreatureScreenState();
}

class _CreatureScreenState extends State<CreatureScreen> with TickerProviderStateMixin {
  bool _controlsHidden = false;

  late final ScrollController _scrollController;
  late final StreamSubscription<PipeEvent> _pipeSub;

  late final AnimationController _controlsAnimationController;
  late final Animation<Offset> _controlsOffsetAnimation;

  late final AnimationController _contentAnimationController;
  late final Animation<Offset> _contentOffsetAnimation;
  late final Animation<double> _imageScaleAnimation;
  late final Animation<double> _imageFadeAnimation;

  // TODO: fix broadcast
  final _scrollPositionController = StreamController<ScrollPosition>.broadcast();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(
      onAttach: (position) {
        _scrollPositionController.add(position);
      },
    );

    // Controls
    _controlsAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    final curvedControls = CurvedAnimation(parent: _controlsAnimationController, curve: Curves.fastEaseInToSlowEaseOut);

    _controlsOffsetAnimation = Tween<Offset>(begin: Offset(-80.0, 0.0), end: Offset.zero).animate(curvedControls);

    // Content
    _contentAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    final curvedController = CurvedAnimation(parent: _contentAnimationController, curve: Curves.fastLinearToSlowEaseIn);

    _contentOffsetAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(curvedController);
    _imageScaleAnimation = Tween<double>(begin: 4.0, end: 1.0).animate(curvedController);
    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(_onScroll);

    _pipeSub = context.deps.pipe.stream().listen(_onPipeEvent);

    _fetchCreature();
  }

  @override
  void dispose() {
    super.dispose();

    _pipeSub.cancel();
    _scrollController.removeListener(_onScroll);
  }

  void _onPipeEvent(PipeEvent event) {
    if (event is CreatureFetchedPipeEvent) {
      _contentAnimationController.reset();
      _contentAnimationController.forward();

      _controlsAnimationController.reset();
      _controlsAnimationController.forward();
    }
  }

  static const _controlsHideThresold = 350;

  // TODO: improve logic
  void _onScroll() {
    if (!_controlsHidden && _scrollController.position.pixels > _controlsHideThresold) {
      _controlsAnimationController.reverse();
      setState(() {
        _controlsHidden = true;
      });
    } else if (_controlsHidden && _scrollController.position.pixels < _controlsHideThresold) {
      _controlsAnimationController.forward();
      setState(() {
        _controlsHidden = false;
      });
    }
  }

  Future<void> _fetchCreature() async => context.deps.creatureBloc.add(FetchCreatureEvent());

  Future<void> _onTapBack() async => context.navigator.pop();

  @override
  Widget build(BuildContext context) {
    return BokuNoScaffold(
      body: RefreshIndicator(
        onRefresh: _fetchCreature,
        child: BlocBuilder<CreatureBloc, BlocState<Creature>>(
          builder: (context, state) {
            if (state.pending) {
              return Center(
                child: const CircularProgressIndicator(color: Color(0xFFEFC261)),
              );
            }

            if (state.hasError) {
              return Text(state.error!);
            }

            if (!state.done) {
              return const Text("Idle");
            }

            final creature = state.value!;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: StreamBuilder(
                    stream: _scrollPositionController.stream,
                    builder: (_, snapshot) => FadeTransition(
                      opacity: _imageFadeAnimation,
                      child: ScaleTransition(
                        scale: _imageScaleAnimation,
                        child: ParallaxImage(scrollPosition: snapshot.data),
                      ),
                    ),
                  ),
                ),
                SlideTransition(
                  position: _contentOffsetAnimation,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height / 1.5 - 50),
                        // TODO: remove
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
                              _NameSection(name: creature.name),
                              const SizedBox(height: 30),
                              _DescriptionSection(description: creature.description),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 30,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: SlideTransition(
                        position: _controlsOffsetAnimation,
                        // TODO: component
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: _onTapBack,
                              child: Container(
                                width: 48,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: context.theme.color.effect.shadow,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back, size: 24, color: Color(0xFF3F3A39)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NameSection extends StatelessWidget {
  const _NameSection({
    required this.name,
  });

  final Name name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name.local,
          style: context.theme.font.header.copyWith(color: context.theme.color.fg.body),
        ),
        name.original == null
            ? SizedBox.shrink()
            : Text(
                name.original!,
                style: context.theme.font.subtitle.copyWith(
                  color: context.theme.color.fg.body.muted,
                ),
              ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.description,
  });

  final String description;

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: LayoutBuilder(builder: (context, constraints) {
        final dropCap = description[0];
        final content = description.substring(1);

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
    );
  }
}
