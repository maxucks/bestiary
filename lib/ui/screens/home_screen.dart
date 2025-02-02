import 'package:bestiary/models/creature.dart';
import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/widgets/boku_no_icon_button.dart';
import 'package:bestiary/ui/widgets/boku_no_input.dart';
import 'package:bestiary/ui/widgets/boku_no_refresh.dart';
import 'package:bestiary/ui/widgets/boku_no_scaffold.dart';
import 'package:bestiary/ui/widgets/creature_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static final _creatures = List.generate(
    20,
    (id) => ListCreature(id: id, name: Name(local: "Каса-обакэ", original: "Cum")),
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onRefresh() async => 0;

  void _onTapCreature() => context.navigator.pushNamed("/creature");

  @override
  Widget build(BuildContext context) {
    return BokuNoScaffold(
      body: BokuNoRefresh(
        onRefresh: _onRefresh,
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
                CreatureCard(
                  onTap: _onTapCreature,
                  creature: HomeScreen._creatures[0],
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
                itemBuilder: (context, index) => CreatureCard(
                  onTap: _onTapCreature,
                  creature: HomeScreen._creatures[index + 1],
                  aspectRatio: 0.6,
                ),
                itemCount: HomeScreen._creatures.length - 1,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
