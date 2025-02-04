import 'package:bestiary/events/bloc_events.dart';
import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/modules/blocs/papers_bloc.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ui/bricks/boku_no_icon_button.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/bricks/input.dart';
import 'package:bestiary/ui/bricks/loader.dart';
import 'package:bestiary/ui/wrappers/boku_no_refresh.dart';
import 'package:bestiary/ui/wrappers/boku_no_scaffold.dart';
import 'package:bestiary/ui/bricks/error_text.dart';
import 'package:bestiary/ui/bricks/image_button.dart';
import 'package:bestiary/ui/wrappers/scrollable_centered.dart';
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

  static const _categoryId = 0;
  static const _gridShimmersCount = 4;

  Future<void> _fetchPapers() async => context.deps.papersBloc.add(FetchPapersEvent(categoryId: _categoryId));
  Future<void> _resfreshPapers() async => context.deps.papersBloc.add(RefreshPapersEvent(categoryId: _categoryId));

  void _onTapCreature() => context.navigator.pushNamed("/paper");

  @override
  Widget build(BuildContext context) {
    return BokuNoScaffold(
      body: BlocBuilder<PapersBloc, BokuNoState<List<ShortPaper>>>(
        builder: (context, state) {
          if (state.isIdle) {
            return Loader();
          }
          if (state.hasError) {
            return ScrollableCentered(
              onRefresh: _resfreshPapers,
              child: ErrorText('Erorr: ${state.errorMessage}'),
            );
          }

          final noContent = !state.isLoading && (state.hasValue && state.value.isEmpty);

          if (noContent) {
            return ScrollableCentered(
              onRefresh: _resfreshPapers,
              child: ErrorText("No content"),
            );
          }

          final isShimmering = state.isPending || state.isRefreshing;

          return BokuNoRefresh(
            onRefresh: _resfreshPapers,
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
                          Expanded(child: TextInput(placeholder: "Найти...")),
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
                    AssetImageButton(title: "О проекте"),
                    const SizedBox(height: 16),
                    ShortPaperCard(
                      onTap: _onTapCreature,
                      paper: isShimmering ? null : state.value.first,
                    ),
                  ]),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) => ShortPaperCard(
                      onTap: _onTapCreature,
                      paper: isShimmering ? null : state.value[index + 1],
                      aspectRatio: 0.6,
                    ),
                    itemCount: isShimmering ? _gridShimmersCount : (state.value.length) - 1,
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
