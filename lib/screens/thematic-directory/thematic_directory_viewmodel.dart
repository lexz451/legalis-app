import 'package:flutter/foundation.dart';
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

  int currentPage = 1;

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

  setCurrentPage(page) {
    currentPage = page;
    notifyListeners();
    fetchNormatives(currentDirectory, page: page);
  }

  setCurrentDirectory(Directory dir, {isChild = false}) {
    if (currentDirectory == dir) return;
    currentDirectory = dir;
    if (isChild) {
      if (breadcrumb.contains(dir)) {
        breadcrumb = breadcrumb.sublist(0, breadcrumb.indexOf(dir));
      } else {
        breadcrumb.add(dir);
      }
    } else {
      breadcrumb = [dir];
    }
    fetchNormatives(dir);
  }

  fetchNormatives(Directory? directory, {int page = 1}) async {
    normatives = Resource.loading();
    try {
      final norms = await normativeRepository.fetchByDirectoryId(directory?.id);
      normatives = Resource.complete(norms);
    } catch (e) {
      normatives = Resource.error(e.toString());
    }
  }

  loadDirectories() async {
    directories = Resource.loading(data: _directories.data);
    try {
      final dirs = await directoryRepository.fetchAll();
      directories =
          Resource.complete(dirs.where((e) => e.icon != null).toList());
      final def = directories.data?.first;
      setCurrentDirectory(def!);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      directories = Resource.error(e.toString(), data: _directories.data);
    }
  }
}
