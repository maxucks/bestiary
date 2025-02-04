import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/paper.dart';
import 'package:bestiary/events/bloc_events.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:bloc/bloc.dart';

typedef _State = BokuNoState<Paper>;

class PaperBloc extends Bloc<PaperEvent, _State> {
  PaperBloc(this._papersRepo, this._pipe) : super(BokuNoState.init()) {
    on<FetchPaperEvent>(_fetchPaper);
    on<RefreshPaperEvent>(_refreshPaper);
  }

  final PapersRepository _papersRepo;
  final Pipe _pipe;

  Future<void> _fetchPaper(FetchPaperEvent event, Emitter<_State> emit) async {
    try {
      emit(state.pending());

      final paper = await _papersRepo.getPaper(event.id);

      emit(state.done(paper));

      _pipe.publish(PaperReadyPipeEvent(paper.id));
    } catch (e) {
      emit(state.error(e.toString()));
    }
  }

  Future<void> _refreshPaper(RefreshPaperEvent event, Emitter<_State> emit) async {
    try {
      emit(state.refreshing());

      final paper = await _papersRepo.getPaper(event.id);

      emit(state.done(paper));

      _pipe.publish(PaperReadyPipeEvent(paper.id));
    } catch (e) {
      emit(state.error(e.toString()));
    }
  }
}
