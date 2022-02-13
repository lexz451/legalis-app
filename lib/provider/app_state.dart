import 'package:flutter/cupertino.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/services/connectivity_service.dart';
import 'package:legalis/services/local_storage_service.dart';

class AppState extends ChangeNotifier {
  bool isLoading = false;

  final ApiService apiService = ApiService();
  final LocalStorageService localStorageService = LocalStorageService();
  final ConnectivityService connectivityService = ConnectivityService();

  List<Gazette> _gazettes = [];
  List<Normative> _normatives = [];

  void setIsLoading(loading) {
    this.isLoading = loading;
    notifyListeners();
  }
}
