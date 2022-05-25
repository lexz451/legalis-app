import 'package:get_it/get_it.dart';
import 'package:legalis/repositories/about_repository.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';
import 'package:legalis/repositories/directory_repository.dart';
import 'package:legalis/repositories/download_repository.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/repositories/glossary_repository.dart';
import 'package:legalis/repositories/news_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/services/storage_service.dart';

final getIt = GetIt.instance;

Future initDI() {
  getIt.registerSingletonAsync<StorageService>(
      () async => StorageService().init());
  getIt.registerSingletonAsync<APIService>(() async => APIService().init());
  getIt.registerSingletonAsync<DirectoryRepository>(
      () async => DirectoryRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync<NormativeRepository>(
      () async => NormativeRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync<GazetteRepository>(
      () async => GazetteRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync<GlossaryRepository>(
      () async => GlossaryRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync<AboutRepository>(() async => AboutRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync<BookmarksRepository>(
      () async => BookmarksRepository(),
      dependsOn: [APIService, StorageService]);
  getIt.registerSingletonAsync<NewsRepository>(() async => NewsRepository(),
      dependsOn: [APIService]);
  getIt.registerSingletonAsync(() async => DownloadRepository(),
      dependsOn: [APIService]);
  return getIt.allReady();
}
