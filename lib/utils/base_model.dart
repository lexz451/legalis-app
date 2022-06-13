import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  bool _disposed = false;

  String? _error;
  String? get error => _error;
  setError(e) {
    _error = e.toString();
    notifyListeners();
  }

  bool _loading = false;
  bool get isLoading => _loading;
  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
