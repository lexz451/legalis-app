import 'package:flutter/cupertino.dart';

List<Route> routeStack = [];

class NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    routeStack.add(route);
  }
}
