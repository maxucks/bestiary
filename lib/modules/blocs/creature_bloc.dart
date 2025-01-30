import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/creature.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bloc/bloc.dart';

typedef _State = BlocState<Creature>;

abstract class CreatureEvent {}

class FetchCreatureEvent extends CreatureEvent {}

class CreatureBloc extends Bloc<CreatureEvent, _State> {
  CreatureBloc(this._pipe) : super(BlocState.idle()) {
    on<FetchCreatureEvent>(_fetchCreature);
  }

  final Pipe _pipe;

  Future<void> _fetchCreature(FetchCreatureEvent event, Emitter<_State> emit) async {
    try {
      emit(BlocState.pending(value: state.value));

      // TODO: remove
      await Future.delayed(const Duration(seconds: 1));

      const creature = Creature(
        id: 0,
        name: Name(local: "Каса-обакэ", original: "からかさ小僧"),
        description:
            "Один из самых известных и популярных видов цукумогами. Как и большинство других цукумогами, каса-обаке появился на свет, скорее всего, в эпоху Эдо благодаря художникам-иллюстраторам, потому что японский народный фольклор не знает никаких сказок, легенд или быличек про это существо. Зато картинок, иллюстраций, манга и аниме с участием каса-обакэ просто не перечесть. Причиной тому — добродушный характер каракаса-обакэ и его запоминающийся облик: подпрыгивающий на одной ноге старый бумажный зонтик с одним глазом и длинным высунутым языком. Это классический облик, придуманный Сигэру Мидзуки. До него облик каса-обакэ был более вариативен — иногда добавлялись две руки, или говорили о его двух глазах, двух ногах.\n\nКак говорится в одной сказке, в большом старом особняке провели тщательную уборку и выкинули множество утвари, которая показалась старой или слишком обычной. Эти предметы, к которым относились посуда, кухонная туварь и даже старая мебель, собрались вместе и составили план по запугиванию обитателей особняка, за то, что те пренебрегли ими.\n\nТакие ожившие предметы выступают в качестве параллели с западным полтергейстом. Их легко обидеть, и, если хозяева будут не достаточно заботиться, то цукумогами могут что-нибудь разбить или сломать",
        aliases: [
          Name(local: "Каракаса-обакэ", original: "かかさ小僧"),
          Name(local: "Касабаса-обакэ", original: "かかさ小僧"),
        ],
        danger: Danger.neutral,
        habitat: Habitat.houses,
        traits: [Trait.social],
      );

      emit(BlocState.done(creature));

      _pipe.publish(CreatureFetchedPipeEvent());
    } catch (e) {
      emit(BlocState.error(e.toString()));
    }
  }
}
