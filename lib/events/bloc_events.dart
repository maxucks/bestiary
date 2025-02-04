abstract class PaperEvent {}

class FetchPaperEvent extends PaperEvent {
  final int id;

  FetchPaperEvent({required this.id});
}

class RefreshPaperEvent extends PaperEvent {
  final int id;

  RefreshPaperEvent({required this.id});
}

abstract class PapersEvent {}

class FetchPapersEvent extends PapersEvent {
  final int categoryId;

  FetchPapersEvent({required this.categoryId});
}

class RefreshPapersEvent extends PapersEvent {
  final int categoryId;

  RefreshPapersEvent({required this.categoryId});
}
