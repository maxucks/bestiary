enum Status {
  idle,
  pending,
  error,
  done,
}

class BlocState<T> {
  final T? value;
  final String? error;
  final Status status;

  BlocState.idle()
      : value = null,
        error = null,
        status = Status.idle;

  BlocState.pending({this.value})
      : error = null,
        status = Status.pending;

  BlocState.error(this.error, {this.value}) : status = Status.error;

  BlocState.done(this.value)
      : error = null,
        status = Status.done;

  get pending => status == Status.pending;
  get hasError => status == Status.error;
  get done => status == Status.done;
}
