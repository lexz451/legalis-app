import 'dart:io';

import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadRepository {
  final apiService = getIt<APIService>();

  Future remove(File file) async {
    bool _hasPermission = await _requestPermission();
    if (!_hasPermission) {
      LOGGER.e("Missing storage permission");
      return false;
    }
    return await file.delete();
  }

  Future<bool> isDownloaded(fileName) async {
    if (fileName == null) return false;
    bool _hasPermission = await _requestPermission();
    if (!_hasPermission) {
      LOGGER.e("Missing storage permission");
      return false;
    }
    final _dir = await getApplicationDocumentsDirectory();
    final _files = _dir.listSync().whereType<File>().toList();
    if (_files.isEmpty) return false;
    return _files.where((e) => e.path.endsWith(fileName)).isNotEmpty;
  }

  Future<List<File>> getDownloadedFiles() async {
    bool _hasPermission = await _requestPermission();
    if (!_hasPermission) {
      LOGGER.e("Missing storage permission");
      return [];
    }
    final _dir = await getApplicationDocumentsDirectory();
    final _contents =
        _dir.listSync().whereType<File>().where((e) => e.path.endsWith(".pdf"));
    return _contents.toList();
  }

  Future<File?> getDownloadedFile(fileName) async {
    if (fileName == null) return null;
    bool _hasPermission = await _requestPermission();
    if (!_hasPermission) {
      LOGGER.e("Missing storage permission");
      return null;
    }
    final _dir = await getApplicationDocumentsDirectory();
    final _files = _dir.listSync().whereType<File>().toList();
    if (_files.isEmpty) return null;
    return _files.firstWhere((e) => e.path.endsWith(fileName));
  }

  Future downloadFile(String url, String fileName) async {
    bool _hasPermission = await _requestPermission();
    if (!_hasPermission) {
      LOGGER.e("Missing storage permission");
      return;
    }
    final _dir = await getApplicationDocumentsDirectory();
    try {
      await apiService.download(url, "${_dir.path}/$fileName");
    } catch (e) {
      LOGGER.e(e);
    }
  }

  Future<bool> _requestPermission() async {
    await Permission.storage.request();
    return await Permission.storage.isGranted;
  }
}
