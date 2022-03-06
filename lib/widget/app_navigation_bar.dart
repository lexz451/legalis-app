import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: null,
      backgroundColor: AppTheme.backgroundColor.withOpacity(.75),
      leading: InkWell(
        onTap: () {
          Routemaster.of(context).pop();
        },
        borderRadius: BorderRadius.circular(360),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 28,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
