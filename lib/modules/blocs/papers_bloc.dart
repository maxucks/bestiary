import 'package:bestiary/events/bloc_events.dart';
import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:bloc/bloc.dart';

typedef _State = BokuNoState<List<ShortPaper>>;

class PapersBloc extends Bloc<PapersEvent, _State> {
  PapersBloc(this._papersRepo) : super(BokuNoState.init()) {
    on<FetchPapersEvent>(_fetchPapers);
    on<RefreshPapersEvent>(_refreshPapers);
  }

  final PapersRepository _papersRepo;

  Future<void> _fetchPapers(FetchPapersEvent event, Emitter<_State> emit) async {
    try {
      emit(state.pending());

      final papers = await _papersRepo.getPapers(event.categoryId);

      emit(state.done(papers));
    } catch (e) {
      emit(state.error(e.toString()));
    }
  }

  Future<void> _refreshPapers(RefreshPapersEvent event, Emitter<_State> emit) async {
    try {
      emit(state.refreshing());

      final papers = await _papersRepo.getPapers(event.categoryId);

      emit(state.done(papers));
    } catch (e) {
      emit(state.error(e.toString()));
    }
  }
}
