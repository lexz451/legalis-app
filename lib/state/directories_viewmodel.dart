import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legalis/model/directory.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/paged.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/directory_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/utils/base_model.dart';

class DirectoriesViewModel extends BaseModel {
  final directoryRepository = GetIt.I<DirectoryRepository>();
  final normativeRepository = GetIt.I<NormativeRepository>();

  List<Directory> breadcrumb = [];
  Directory? _currentDirectory;
  Resource<List<Directory>> _directories = Resource.loading();
  Resource<Paged<Normative>> _norms = Resource.loading();

  Directory? get currentDirectory => _currentDirectory;
  Resource<List<Directory>> get directories => _directories;
  Resource<Paged<Normative>> get normatives => _norms;

  set directories(Resource<List<Directory>> directories) {
    _directories = directories;
    notifyListeners();
  }

  set normatives(Resource<Paged<Normative>> norms) {
    _norms = norms;
    notifyListeners();
  }

  set currentDirectory(Directory? dir) {
    _currentDirectory = dir;
    notifyListeners();
  }

  setCurrentDirectory(Directory dir, {isChild = false}) {
    if (currentDirectory == dir) return;
    currentDirectory = dir;
    if (isChild) {
      if (breadcrumb.contains(dir)) {
        final _breadcrumb = breadcrumb.sublist(0, breadcrumb.indexOf(dir));
        breadcrumb = _breadcrumb;
      } else {
        breadcrumb.add(dir);
      }
    } else {
      breadcrumb = [dir];
    }
    fetchNormatives(dir);
  }

  fetchNormatives(Directory? directory) async {
    normatives = Resource.loading();
    try {
      final _norms =
          await normativeRepository.fetchByDirectoryId(directory?.id);
      normatives = Resource.complete(_norms);
    } catch (e) {
      normatives = Resource.error(e.toString());
    }
  }

  loadDirectories() async {
    directories = Resource.loading();
    try {
      final _directories = await directoryRepository.fetchAll();
      directories =
          Resource.complete(_directories.where((e) => e.icon != null).toList());
      final _default = directories.data?.first;
      setCurrentDirectory(_default!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      directories = Resource.error(e.toString());
    }
  }
}