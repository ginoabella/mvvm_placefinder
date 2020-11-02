class ErrorService {
  static bool _error = false;
  static String _description = '';

  static bool hasError({bool reset = false}) {
    final bool err = _error;
    if (reset) _error = false;

    return err;
  }

  static void setError({String description = ''}) {
    _description = description;
    _error = true;
  }

  static String get errorDescription => _description;
}
