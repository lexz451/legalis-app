import 'package:flutter/cupertino.dart';
import 'package:legalis/app.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  Routemaster.setPathUrlStrategy();
  runApp(App());
}
