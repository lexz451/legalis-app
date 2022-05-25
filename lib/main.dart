import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:legalis/di.dart';
import 'package:legalis/router.dart';
import 'package:legalis/screens/app_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// ignore: non_constant_identifier_names
final LOGGER = Logger();

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  Routemaster.setPathUrlStrategy();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await initDI();
  SentryFlutter.init((config) {
    config.dsn =
        "https://6eca271f462c4075a6eb9858a32d59f8@o1254650.ingest.sentry.io/6422681";
    config.tracesSampleRate = 1.0;
  }, appRunner: () {
    runApp(ChangeNotifierProvider<AppViewModel>(
      create: (_) => AppViewModel()..init(),
      child: MaterialApp.router(
        title: "Legalis",
        theme: AppTheme.theme,
        routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routeMap),
        routeInformationParser: const RoutemasterParser(),
      ),
    ));
    FlutterNativeSplash.remove();
  });
}
