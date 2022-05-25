import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/home.dart';
import 'package:legalis/screens/about/about_screen.dart';
import 'package:legalis/screens/advanced-search/advanced_search_screen.dart';
import 'package:legalis/screens/bookmarks/bookmarks_screen.dart';
import 'package:legalis/screens/dashboard/dashboard_screen.dart';
import 'package:legalis/screens/downloads/downloads_screen.dart';
import 'package:legalis/screens/gazette/gazettes_screen.dart';
import 'package:legalis/screens/glossary/glossary_screen.dart';
import 'package:legalis/screens/help/help_screen.dart';
import 'package:legalis/screens/normative/normative_screen.dart';
import 'package:legalis/screens/pdfviewer/pdfviewer_screen.dart';
import 'package:legalis/screens/popular/popular_normatives_screen.dart';
import 'package:legalis/screens/recent/recent_normative_screen.dart';
import 'package:legalis/screens/search-results/search_results_screen.dart';
import 'package:legalis/screens/settings/settings_screen.dart';
import 'package:legalis/screens/thematic-directory/thematic_directory_screen.dart';
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
  '/dashboard/advanced-search': (router) =>
      const CupertinoPage(child: AdvancedSearchScreen()),
  '/dashboard/search-results': (route) =>
      CupertinoPage(child: SearchResultsScreen(params: route.queryParameters)),

  '/dashboard/directories/normatives/:id': (route) => _goToNormative(route),
  '/dashboard/search-results/normatives/:id': (route) => _goToNormative(route),
  '/dashboard/search-results/normatives/:id/viewer/:file': (route) =>
      _goToViewer(route),
  '/dashboard/directories/normatives/:id/viewer/:file': (route) =>
      _goToViewer(route),

  //'/dashboard/normatives/:id': (route) => _goToNormative(route),
  '/normative/:id': (route) => _goToNormative(route),
  '/viewer/:file': (route) => _goToViewer(route),

  '/bookmarks/normatives/:id': (route) => _goToNormative(route),
  '/bookmarks': (route) => const MaterialPage(child: Bookmarks()),
  '/downloads': (route) => const MaterialPage(child: DownloadsScreen()),
  '/settings': (route) => const MaterialPage(child: SettingsScreen()),
  '/settings/glossary': (route) => const CupertinoPage(child: GlossaryScreen()),
  '/settings/help': (route) => const CupertinoPage(child: HelpScreen()),
  '/settings/about': (route) => const CupertinoPage(child: AboutScreen()),
  '/settings/contact': (route) => const CupertinoPage(child: HelpScreen())
});
