import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/layout/layout.dart';
import 'package:legalis/provider/app_state.dart';
import 'package:legalis/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: CupertinoApp(
        theme: AppTheme.themeData,
        home: Layout(),
      ),
    );
  }
}
