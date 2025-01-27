import 'dart:async';

import 'package:bestiary/events/pipe_event.dart';
import 'package:bestiary/ports/adapters.dart';

class EventPipe implements Pipe {
  late final StreamController<PipeEvent> _controller;
  late final Stream<PipeEvent> _stream;

  EventPipe() {
    _controller = StreamController<PipeEvent>.broadcast();
    _stream = _controller.stream;
  }

  @override
  Stream<PipeEvent> stream() {
    return _stream;
  }

  @override
  void publish(PipeEvent event) {
    _controller.add(event);
  }
}
