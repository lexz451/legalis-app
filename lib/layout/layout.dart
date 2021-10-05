import 'package:flutter/cupertino.dart';
import 'package:legalis/layout/footer/footer.dart';
import 'package:legalis/layout/header/header.dart';
import 'package:legalis/layout/main/main.dart';
import 'package:legalis/theme.dart';

class Layout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    child: Main(),
                  ),
                  Footer()
                ],
              ),
            )),
      );
    });
  }
}
