import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/models/paper.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bestiary/ports/repositories.dart';
import 'package:bloc/bloc.dart';

typedef _State = BokuNoState<Paper>;

abstract class PaperEvent {}

class FetchPaperEvent extends PaperEvent {
  final int id;

  FetchPaperEvent(this.id);
}

class PaperBloc extends Bloc<PaperEvent, _State> {
  PaperBloc(this._papersRepo, this._pipe) : super(BokuNoState.idle()) {
    on<FetchPaperEvent>(_fetchPaper);
  }

  final PapersRepository _papersRepo;
  final Pipe _pipe;

  Future<void> _fetchPaper(FetchPaperEvent event, Emitter<_State> emit) async {
    try {
      emit(BokuNoState.pending(value: state.value));

      final paper = await _papersRepo.getPaper(event.id);

      emit(BokuNoState.done(paper));

      _pipe.publish(PaperFetchedPipeEvent(paper.id));
    } catch (e) {
      emit(BokuNoState.error(e.toString()));
    }
  }
}
