import 'dart:async';

import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/events/popup_event.dart';
import 'package:bestiary/modules/blocs/state.dart';
import 'package:bestiary/ports/adapters.dart';
import 'package:bloc/bloc.dart';

abstract class NotificationsEvent {}

class NotificationsBloc extends Bloc<NotificationsEvent, AppState<Never>> {
  final Pipe _pipe;
  late final StreamSubscription<PipeEvent> sub;

  final _popupController = StreamController<PopupEvent>.broadcast();
  late final _popupStream = _popupController.stream;

  NotificationsBloc(this._pipe) : super(AppState.idle()) {
    sub = _pipe.stream().listen(_onPipeEvent);
  }

  Stream<PopupEvent> get popupStream {
    return _popupStream;
  }

  _onPipeEvent(PipeEvent event) {
    if (event is BooksCachedPipeEvent) {
      _popupController.add(PopupEvent("Cached", "Books were cached"));
    }
  }
}
