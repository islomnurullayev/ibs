import 'package:ibs/blocs/base/ajax.dart';

class SimpleGetState<T> extends AjaxState {
  T? data;
  Map<String, dynamic>? params;

  SimpleGetState({
    this.data,
    this.params,
    bool fetching = false,
    Exception? exception,
  }) : super(fetching: fetching, exception: exception);

  void reset() {
    data = null;
    exception = null;
    fetching = false;
  }
}
