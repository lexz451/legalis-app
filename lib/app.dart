import 'package:flutter/cupertino.dart';
import 'package:legalis/layout/layout.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => AppState());
  }
}
