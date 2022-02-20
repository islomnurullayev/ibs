class AjaxState {
  bool fetching = false;
  Exception? exception;

  AjaxState({
    this.fetching = false,
    this.exception,
  });

  bool get hasException => exception != null;
}
