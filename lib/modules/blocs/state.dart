enum Status {
  idle,
  pending,
  error,
  done,
}

class AppState<T> {
  final T? value;
  final String? error;
  final Status status;

  AppState.idle()
      : value = null,
        error = null,
        status = Status.idle;

  AppState.pending({this.value})
      : error = null,
        status = Status.pending;

  AppState.error(this.error, {this.value}) : status = Status.error;

  AppState.done(this.value)
      : error = null,
        status = Status.done;
}
