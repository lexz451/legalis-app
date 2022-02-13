import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:legalis/provider/app_state.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: CupertinoApp(
          theme: AppTheme.themeData,
          home: CupertinoTabScaffold(
            controller: tabState.controller,
            tabBuilder: tabState.tabBuilder,
            tabBar: CupertinoTabBar(
              inactiveColor: CupertinoColors.white.withOpacity(.6),
              iconSize: 26,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.rectangle_stack)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.bookmark)),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.arrow_down_circle)),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.ellipsis_vertical_circle)),
              ],
            ),
          )),
    );
  }
}
