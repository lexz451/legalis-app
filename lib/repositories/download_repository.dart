import 'dart:io';

import 'package:legalis/di.dart';
import 'package:legalis/main.dart';
import 'package:legalis/services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadRepository {
  final apiService = getIt<APIService>();

  Future remove(File file) async {
    // bool hasPermission = await _requestPermission();
    // if (!hasPermission) {
    //   LOGGER.e("Missing storage permission");
    //   return false;
    // }
    return await file.delete();
  }

  Future<bool> isDownloaded(fileName) async {
    if (fileName == null) return false;
    // bool hasPermission = await _requestPermission();
    // if (!hasPermission) {
    //   LOGGER.e("Missing storage permission");
    //   return false;
    // }
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync().whereType<File>().toList();
    if (files.isEmpty) return false;
    return files.where((e) => e.path.endsWith(fileName)).isNotEmpty;
  }

  Future<List<File>> getDownloadedFiles() async {
    // bool hasPermission = await _requestPermission();
    // if (!hasPermission) {
    //   LOGGER.e("Missing storage permission");
    //   return [];
    // }
    final dir = await getApplicationDocumentsDirectory();
    final contents =
        dir.listSync().whereType<File>().where((e) => e.path.endsWith(".pdf"));
    return contents.toList();
  }

  Future<File?> getDownloadedFile(fileName) async {
    if (fileName == null) return null;
    // bool hasPermission = await _requestPermission();
    // if (!hasPermission) {
    //   LOGGER.e("Missing storage permission");
    //   return null;
    // }
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync().whereType<File?>().toList();
    if (files.isEmpty) return null;
    return files.firstWhere((e) => e!.path.endsWith(fileName),
        orElse: () => null);
  }

  Future downloadFile(String url, String fileName) async {
    // bool hasPermission = await _requestPermission();
    // if (!hasPermission) {
    //   LOGGER.e("Missing storage permission");
    //   return;
    // }
    final dir = await getApplicationDocumentsDirectory();
    try {
      await apiService.download(url, "${dir.path}/$fileName");
    } catch (e) {
      LOGGER.e(e);
    }
  }

  Future<bool> _requestPermission() async {
    await Permission.storage.request();
    return await Permission.storage.isGranted;
  }
}
