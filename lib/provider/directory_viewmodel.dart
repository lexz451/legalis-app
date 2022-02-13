import 'package:flutter/foundation.dart';
import 'package:legalis/model/directory.dart';
import 'package:legalis/model/error.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/response.dart';
import 'package:legalis/repository/directory_repository.dart';
import 'package:legalis/repository/normative_repository.dart';

class DirectoryViewModel extends ChangeNotifier {
  final DirectoryRepository _directoryRepository = DirectoryRepository();
  final NormativeRepository _normativeRepository = NormativeRepository();

  Response<List<Directory>> _directories =
      Response(state: ResponseState.LOADING);

  Response<Paged<Normative>> _normatives =
      Response(state: ResponseState.LOADING);

  Directory? _selectedDirectory;

  Response<List<Directory>> get directories => this._directories;
  Response<Paged<Normative>> get normatives => this._normatives;
  Directory? get selectedDirectory => this._selectedDirectory;

  void _setDirectories(Response<List<Directory>> response) {
    this._directories = response;
    notifyListeners();
  }

  void _setNormatives(Response<Paged<Normative>> response) {
    this._normatives = response;
    notifyListeners();
  }

  void _setSelectedDirectory(Directory directory) {
    this._selectedDirectory = directory;
    notifyListeners();
  }

  void loadDirectories() async {
    _setDirectories(Response.loading());
    try {
      var _dirs = await _directoryRepository.fetchAll();
      _setDirectories(Response.complete(_dirs));
      _onDirectorySelected(_dirs.first);
    } on Error catch (e) {
      _setDirectories(Response.error(e.message ?? "Error desconocido"));
    }
  }

  void _onDirectorySelected(Directory directory) async {
    _setSelectedDirectory(directory);
    _setNormatives(Response.loading());
    try {
      var _res = await _normativeRepository.fetchByDirectoryId(directory.id);
      _setNormatives(Response.complete(_res));
    } on Error catch (e) {
      _setNormatives(Response.error(e.message ?? "Error desconocido"));
    }
  }

  void onDirectorySelected(Directory directory) =>
      _onDirectorySelected(directory);
}
