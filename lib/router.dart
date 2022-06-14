import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/home.dart';
import 'package:legalis/screens/about/about_screen.dart';
import 'package:legalis/screens/advanced-search/advanced_search_screen.dart';
import 'package:legalis/screens/bookmarks/bookmarks_screen.dart';
import 'package:legalis/screens/dashboard/dashboard_screen.dart';
import 'package:legalis/screens/downloads/downloads_screen.dart';
import 'package:legalis/screens/gazette-detail/gazette_screen.dart';
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
  final id = route.pathParameters['id'];
  return id != null
      ? CupertinoPage(child: NormativeScreen(id: id))
      : const Redirect("/dashboard");
}

_goToGazette(RouteData route) {
  final id = route.pathParameters['id'];
  return id != null
      ? CupertinoPage(child: GazetteScreen(id: id))
      : const Redirect("/dashboard");
}

_goToViewer(RouteData route) {
  final file = route.pathParameters['file'];
  final startpage = route.queryParameters['startpage'];
  return file != null
      ? CupertinoPage(
          child: PdfViewerScreen(
          file: file,
          startpage: int.parse(startpage ?? '0'),
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

  '/dashboard/advanced-search/search-results': (route) =>
      CupertinoPage(child: SearchResultsScreen(params: route.queryParameters)),
  '/dashboard/advanced-search/search-results/normative/:id': (route) =>
      _goToNormative(route),
  '/dashboard/advanced-search/search-results/normative/:id/viewer/:file':
      (route) => _goToViewer(route),

  '/dashboard/directories/normative/:id': (route) => _goToNormative(route),
  '/dashboard/directories/normative/:id/viewer/:file': (route) =>
      _goToViewer(route),

  '/dashboard/normative/:id': (route) => _goToNormative(route),

  '/dashboard/search-results': (route) =>
      CupertinoPage(child: SearchResultsScreen(params: route.queryParameters)),

  '/normative/:id': (route) => _goToNormative(route),
  '/gazette/:id': (route) => _goToGazette(route),
  '/viewer/:file': (route) => _goToViewer(route),

  //'/bookmarks/normatives/:id': (route) => _goToNormative(route),
  '/bookmarks': (route) => const MaterialPage(child: Bookmarks()),
  '/downloads': (route) => const MaterialPage(child: DownloadsScreen()),
  '/settings': (route) => const MaterialPage(child: SettingsScreen()),
  '/settings/glossary': (route) => const CupertinoPage(child: GlossaryScreen()),
  '/settings/help': (route) => const CupertinoPage(child: HelpScreen()),
  '/settings/about': (route) => const CupertinoPage(child: AboutScreen()),
  '/settings/contact': (route) => const CupertinoPage(child: HelpScreen())
});
