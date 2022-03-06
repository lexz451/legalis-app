import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);

    return CupertinoTabScaffold(
      controller: tabState.controller,
      tabBuilder: tabState.tabBuilder,
      tabBar: CupertinoTabBar(
        backgroundColor: AppTheme.primary,
        iconSize: 22,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }
}
