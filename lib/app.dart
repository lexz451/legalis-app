import 'package:eventify/eventify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legalis/home.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/model/resource.dart';
import 'package:legalis/repositories/normative_repository.dart';
import 'package:legalis/screens/about_screen.dart';
import 'package:legalis/screens/bookmarks_screen.dart';
import 'package:legalis/screens/directories_screen.dart';
import 'package:legalis/screens/downloads_screen.dart';
import 'package:legalis/screens/dashboard_screen.dart';
import 'package:legalis/screens/gazettes_screen.dart';
import 'package:legalis/screens/glossary_screen.dart';
import 'package:legalis/screens/help_screen.dart';
import 'package:legalis/screens/normative_screen.dart';
import 'package:legalis/screens/pdfviewer_screen.dart';
import 'package:legalis/screens/popular_normatives_screen.dart';
import 'package:legalis/screens/recent_normative_screen.dart';
import 'package:legalis/screens/search_results_screen.dart';
import 'package:legalis/screens/settings_screen.dart';
import 'package:legalis/state/app_viewmodel.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

_goToNormative(route) {
  final _id = route.pathParameters['id'];
  return _id != null
      ? CupertinoPage(child: NormativeScreen(id: _id))
      : const Redirect("/dashboard");
}

_goToViewer(RouteData route) {
  final _file = route.pathParameters['file'];
  return _file != null
      ? CupertinoPage(
          child: PdfViewerScreen(
          file: _file,
        ))
      : const Redirect("/dashboard");
}

final routeMap = RouteMap(routes: {
  '/': (route) => const CupertinoTabPage(
      child: HomePage(),
      paths: ['/dashboard', '/bookmarks', '/downloads', '/settings']),
  '/dashboard': (route) => const MaterialPage(child: DashboardScreen()),
  '/dashboard/gazettes': (route) =>
      const CupertinoPage(child: GazettesScreen()),
  '/dashboard/directories': (route) =>
      const CupertinoPage(child: Directories()),
  '/dashboard/recent': (route) => const CupertinoPage(child: RecentNormative()),
  '/dashboard/popular': (route) =>
      const CupertinoPage(child: PopularNormativeScreen()),
  '/dashboard/search-results': (route) =>
      CupertinoPage(child: SearchResultsScreen(params: route.queryParameters)),
  '/dashboard/directories/normatives/:id': (route) => _goToNormative(route),
  '/dashboard/search-results/normatives/:id': (route) => _goToNormative(route),
  '/dashboard/directories/normatives/:id/viewer/:file': (route) =>
      _goToViewer(route),
  //'/dashboard/normatives/:id': (route) => _goToNormative(route),
  '/bookmarks/normatives/:id': (route) => _goToNormative(route),
  '/bookmarks': (route) => const MaterialPage(child: Bookmarks()),
  '/downloads': (route) => const MaterialPage(child: DownloadsScreen()),
  '/settings': (route) => const MaterialPage(child: SettingsScreen()),
  '/settings/glossary': (route) => const CupertinoPage(child: GlossaryScreen()),
  '/settings/help': (route) => const CupertinoPage(child: HelpScreen()),
  '/settings/about': (route) => const CupertinoPage(child: AboutScreen()),
  '/settings/contact': (route) => const CupertinoPage(child: HelpScreen())
});

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppViewModel()..loadBookmarks(),
        child: MaterialApp.router(
          theme: AppTheme.theme,
          routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routeMap),
          routeInformationParser: const RoutemasterParser(),
        ));
  }
}
