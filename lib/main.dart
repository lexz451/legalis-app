import 'package:flutter/cupertino.dart';
import 'package:legalis/app.dart';
import 'package:legalis/layout/pages/advanced_search_page.dart';
import 'package:legalis/layout/pages/analysis_page.dart';
import 'package:legalis/layout/pages/bookmarks_page.dart';
import 'package:legalis/layout/pages/directory_page.dart';
import 'package:legalis/layout/pages/downloads_page.dart';
import 'package:legalis/layout/pages/home_page.dart';
import 'package:legalis/layout/pages/how_to_search_page.dart';
import 'package:legalis/layout/pages/popular_normative_page.dart';
import 'package:legalis/layout/pages/recent_normative_page.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(routes: {
  '/': (_) => CupertinoTabPage(
      child: App(), paths: ['/home', '/bookmarks', '/downloads']),
  '/home': (_) => CupertinoPage(child: HomePage()),
  '/home/advanced-search': (_) => CupertinoPage(child: AdvancedSearchPage()),
  '/home/thematic-directory': (_) => CupertinoPage(child: DirectoryPage()),
  '/home/how-to-search': (_) => CupertinoPage(child: HowToSearchPage()),
  '/home/recent-normative': (_) => CupertinoPage(child: RecentNormativePage()),
  '/home/popular-normative': (_) =>
      CupertinoPage(child: PopularNormativePage()),
  '/home/analysis': (_) => CupertinoPage(child: AnalysisPage()),
  '/bookmarks': (_) => CupertinoPage(child: BookmarksPage()),
  '/downloads': (_) => CupertinoPage(child: DownloadsPage())
});

void main() {
  runApp(CupertinoApp.router(
    routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
    routeInformationParser: RoutemasterParser(),
  ));
}
