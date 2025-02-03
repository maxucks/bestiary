import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/short_paper.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:bloc/bloc.dart';

typedef _State = BokuNoState<List<ShortPaper>>;

abstract class PapersEvent {}

class FetchPapersEvent extends PapersEvent {
  final int categoryId;

  FetchPapersEvent(this.categoryId);
}

class PapersBloc extends Bloc<PapersEvent, _State> {
  PapersBloc(this._papersRepo, this._pipe) : super(BokuNoState.idle()) {
    on<FetchPapersEvent>(_fetchPapers);
  }

  final PapersRepository _papersRepo;
  final Pipe _pipe;

  Future<void> _fetchPapers(FetchPapersEvent event, Emitter<_State> emit) async {
    try {
      emit(BokuNoState.pending(value: state.value));

      final papers = await _papersRepo.getPapers(event.categoryId);

      emit(BokuNoState.done(papers));

      _pipe.publish(PapersFetchedPipeEvent(event.categoryId));
    } catch (e) {
      emit(BokuNoState.error(e.toString()));
    }
  }
}
