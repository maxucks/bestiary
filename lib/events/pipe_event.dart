class PipeEvent {}

class PaperFetchedPipeEvent extends PipeEvent {
  final int id;

  PaperFetchedPipeEvent(this.id);
}

class PapersFetchedPipeEvent extends PipeEvent {
  final int categoryId;

  PapersFetchedPipeEvent(this.categoryId);
}
