import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/modules/blocs/papers_bloc.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/widgets/boku_no_icon_button.dart';
import 'package:bestiary/ui/widgets/boku_no_input.dart';
import 'package:bestiary/ui/widgets/boku_no_refresh.dart';
import 'package:bestiary/ui/widgets/boku_no_scaffold.dart';
import 'package:bestiary/ui/widgets/short_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fetchPapers();
  }

  Future<void> _fetchPapers() async => context.deps.papersBloc.add(FetchPapersEvent(0));

  void _onTapCreature() => context.navigator.pushNamed("/paper");

  @override
  Widget build(BuildContext context) {
    return BokuNoScaffold(
      body: BlocBuilder<PapersBloc, BokuNoState<List<ShortPaper>>>(
        builder: (context, state) {
          if (!(state.pending || state.done)) {
            return Center(
              child: const CircularProgressIndicator(color: Color(0xFFEFC261)),
            );
          }

          return BokuNoRefresh(
            onRefresh: _fetchPapers,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverSafeArea(
                  right: false,
                  left: false,
                  bottom: false,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.fromLTRB(13, 16, 13, 0),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: BokuNoInput(placeholder: "Найти...")),
                          const SizedBox(width: 8),
                          BokuNoIconButton(icon: Icons.star_rounded, color: context.theme.color.accent.star),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  sliver: SliverList.list(children: [
                    SizedBox(
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context.theme.color.bg.cover.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state.pending)
                      AspectRatio(
                        aspectRatio: 0.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.theme.color.bg.cover.secondary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      )
                    else if (state.value!.isEmpty)
                      SizedBox.shrink()
                    else
                      ShortPaperCard(
                        onTap: _onTapCreature,
                        paper: state.value![0],
                      ),
                  ]),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  sliver: state.pending
                      ? SliverGrid.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) => DecoratedBox(
                            decoration: BoxDecoration(
                              color: context.theme.color.bg.cover.secondary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          itemCount: 4,
                        )
                      : SliverGrid.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) => ShortPaperCard(
                            onTap: _onTapCreature,
                            paper: state.value![index + 1],
                            aspectRatio: 0.6,
                          ),
                          itemCount: (state.value?.length ?? 1) - 1,
                        ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
