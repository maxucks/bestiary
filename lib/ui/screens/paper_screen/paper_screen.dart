import 'dart:async';

import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/paper.dart';
import 'package:bestiary/modules/blocs/paper_bloc.dart';
import 'package:bestiary/events/bloc_events.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ui/bricks/boku_no_back_button.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/bricks/loader.dart';
import 'package:bestiary/ui/bricks/error_text.dart';
import 'package:bestiary/ui/bricks/parallax_image.dart';
import 'package:bestiary/ui/painters/max_lines_text_painter.dart';
import 'package:bestiary/ui/wrappers/boku_no_scaffold.dart';
import 'package:bestiary/ui/wrappers/list_of_paper.dart';
import 'package:bestiary/ui/wrappers/scrollable_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_section.dart';
part 'description_section.dart';

class PaperScreen extends StatefulWidget {
  const PaperScreen({
    super.key,
  });

  @override
  State<PaperScreen> createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> with TickerProviderStateMixin {
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

  static const int _contentAnimationDuration = 700;
  static const int _controlsAnimationDuration = 1000;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(
      onAttach: (position) {
        _scrollPositionController.add(position);
      },
    );

    _initControlsAnimation();
    _initContentAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(_onScroll);
    _pipeSub = context.deps.pipe.stream().listen(_onPipeEvent);

    _fetchPaper();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_onScroll);
    _pipeSub.cancel();
  }

  void _initControlsAnimation() {
    _controlsAnimationController = AnimationController(
      duration: Duration(milliseconds: _controlsAnimationDuration),
      vsync: this,
    );

    final controller = CurvedAnimation(
      parent: _controlsAnimationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    );

    final tween = Tween<Offset>(begin: Offset(-80.0, 0.0), end: Offset.zero);
    _controlsOffsetAnimation = tween.animate(controller);
  }

  void _initContentAnimation() {
    _contentAnimationController = AnimationController(
      duration: Duration(milliseconds: _contentAnimationDuration),
      vsync: this,
    );

    final controller = CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    final offsetTween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
    _contentOffsetAnimation = offsetTween.animate(controller);

    final scaleTween = Tween<double>(begin: 4.0, end: 1.0);
    _imageScaleAnimation = scaleTween.animate(controller);

    final fadeTween = Tween<double>(begin: 0.0, end: 1.0);
    _imageFadeAnimation = fadeTween.animate(controller);
  }

  void _restartAnimation() {
    _contentAnimationController.reset();
    _contentAnimationController.forward();

    _controlsAnimationController.reset();
    _controlsAnimationController.forward();
  }

  void _onPipeEvent(PipeEvent event) {
    if (event is PaperReadyPipeEvent) {
      _restartAnimation();
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

  Future<void> _onTapBack() async => context.navigator.pop();

  Future<void> _fetchPaper() async => context.deps.paperBloc.add(FetchPaperEvent(id: 0));

  Future<void> _refreshPaper() async => context.deps.paperBloc.add(RefreshPaperEvent(id: 0));

  @override
  Widget build(BuildContext context) {
    return BokuNoScaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPaper,
        child: BlocBuilder<PaperBloc, BokuNoState<Paper>>(
          builder: (context, state) {
            if (state.isIdle || state.isLoading) {
              return Loader();
            }
            if (state.hasError) {
              return ScrollableCentered(child: ErrorText(state.errorMessage));
            }
            if (!state.hasValue) {
              return ScrollableCentered(child: ErrorText("Unexpected null state value"));
            }

            final paper = state.value;

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
                        child: ParallaxImage(
                          scrollPosition: snapshot.data,
                          imageUrl: paper.imageUrl,
                        ),
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
                        ListOfPaper(children: [
                          const SizedBox(height: 52),
                          _NameSection(title: paper.title, originalTitle: paper.originalTitle),
                          const SizedBox(height: 42),
                          _DescriptionSection(description: paper.description),
                          const SizedBox(height: 100),
                        ]),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  top: 30,
                  child: SafeArea(
                    child: SlideTransition(
                      position: _controlsOffsetAnimation,
                      child: BokuNoBackButton(onTap: _onTapBack),
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
