class PipeEvent {}

class PaperReadyPipeEvent extends PipeEvent {
  final int id;

  PaperReadyPipeEvent(this.id);
}
