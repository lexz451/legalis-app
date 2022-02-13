import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/layout/widgets/search-box.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller = TextEditingController();
  late final FocusNode _focusNode = FocusNode();

  final mainMenu = [
    {'title': 'Búsqueda Avanzada', 'route': 'advanced-search'},
    {'title': 'Directorio Temático', 'route': 'thematic-directory'},
    {'title': 'Como buscar', 'route': 'how-to-search'},
    {'title': 'Normativa reciente', 'route': 'recent-normative'},
    {'title': 'Normativas populares', 'route': 'popular-normative'},
    {'title': 'Análisis', 'route': 'analysis'},
  ];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppTheme.deepBlue,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg-sm.jpg"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            SizedBox(
              height: 52,
            ),
            Image.asset(
              "assets/images/legalis-logo.png",
              width: 150,
              cacheWidth: 412,
              cacheHeight: 322,
            ),
            SizedBox(
              height: 8,
            ),
            Text("Búsqueda fácil en la legislación cubana"),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: SearchBox(
                  controller: _controller,
                  focusNode: _focusNode,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Column(
                children: mainMenu
                    .map((e) => Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: mainMenu.indexOf(e) == 0
                                          ? CupertinoColors.opaqueSeparator
                                              .withOpacity(.2)
                                          : Colors.transparent),
                                  bottom: BorderSide(
                                      color: CupertinoColors.opaqueSeparator
                                          .withOpacity(.2)))),
                          child: GestureDetector(
                            onTap: () =>
                                Routemaster.of(context).push(e['route']!),
                            child: Center(
                              child: Text(
                                e['title']!.toUpperCase(),
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ))
                    .toList())
          ]),
        ));
  }
}
