import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:legalis/app.dart';
import 'package:legalis/repositories/about_repository.dart';
import 'package:legalis/repositories/bookmarks_repository.dart';
import 'package:legalis/repositories/directory_repository.dart';
import 'package:legalis/repositories/gazette_repository.dart';
import 'package:legalis/repositories/glossary_repository.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/services/api_service.dart';
import 'package:legalis/services/localstorage_service.dart';
import 'package:routemaster/routemaster.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingletonAsync<LocalStorageService>(
      () async => LocalStorageService().init());
  getIt.registerSingletonAsync<APIService>(() async => APIService().init());
  getIt.registerSingletonAsync<DirectoryRepository>(
      () async => DirectoryRepository(),
      dependsOn: [APIService, LocalStorageService]);
  getIt.registerSingletonAsync<NormativeRepository>(
      () async => NormativeRepository(),
      dependsOn: [APIService, LocalStorageService]);
  getIt.registerSingletonAsync<GazetteRepository>(
      () async => GazetteRepository(),
      dependsOn: [APIService, LocalStorageService]);
  getIt.registerSingletonAsync<GlossaryRepository>(
      () async => GlossaryRepository(),
      dependsOn: [APIService, LocalStorageService]);
  getIt.registerSingletonAsync<AboutRepository>(() async => AboutRepository(),
      dependsOn: [APIService, LocalStorageService]);
  getIt.registerSingletonAsync<BookmarksRepository>(
      () async => BookmarksRepository(),
      dependsOn: [APIService, LocalStorageService]);
}

void main() {
  setup();
  Routemaster.setPathUrlStrategy();
  FlutterNativeSplash.removeAfter((context) async => await getIt
      .allReady()
      .then((value) => Future.delayed(const Duration(milliseconds: 250))));
  runApp(FutureBuilder(
      future: getIt.allReady(),
      builder: (context, state) {
        if (state.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return const App();
      }));
}
