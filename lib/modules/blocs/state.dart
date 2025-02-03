enum Status {
  idle,
  pending,
  error,
  done,
}

class BokuNoState<T> {
  final T? value;
  final String? error;
  final Status status;

  BokuNoState.idle()
      : value = null,
        error = null,
        status = Status.idle;

  BokuNoState.pending({this.value})
      : error = null,
        status = Status.pending;

  BokuNoState.error(this.error, {this.value}) : status = Status.error;

  BokuNoState.done(this.value)
      : error = null,
        status = Status.done;

  get pending => status == Status.pending;
  get hasError => status == Status.error;
  get done => status == Status.done;
}
