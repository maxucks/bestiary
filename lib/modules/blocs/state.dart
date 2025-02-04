enum Status {
  idle,
  pending,
  refreshing,
  paginating,
  error,
  done,
}

class BokuNoState<T> {
  final T? _value;
  final String? _error;
  final Status _status;

  BokuNoState({
    required Status status,
    T? value,
    String? error,
  })  : _value = value,
        _error = error,
        _status = status;

  BokuNoState.init()
      : _value = null,
        _error = null,
        _status = Status.idle;

  BokuNoState<T> idle() => BokuNoState(value: null, error: null, status: Status.idle);
  BokuNoState<T> pending() => BokuNoState(value: this._value, error: null, status: Status.pending);
  BokuNoState<T> refreshing() => BokuNoState(value: this._value, error: null, status: Status.refreshing);
  BokuNoState<T> paginating() => BokuNoState(value: this._value, error: null, status: Status.paginating);
  BokuNoState<T> error(String? error) => BokuNoState(value: this._value, error: error, status: Status.error);
  BokuNoState<T> done(T value) => BokuNoState(value: value, error: null, status: Status.done);

  T get value => _value!;
  T? get valueOrNull => _value;
  String get errorMessage => _error!;
  String? get errorMessageOrNull => _error;
  Status get status => _status;

  bool get hasValue => _value != null;
  bool get hasError => status == Status.error;

  bool get isIdle => status == Status.idle;
  bool get isPending => status == Status.pending;
  bool get isRefreshing => status == Status.refreshing;
  bool get isPaginating => status == Status.paginating;
  bool get isLoading => status == Status.pending || status == Status.refreshing || status == Status.paginating;
  bool get isDone => status == Status.done;
}
