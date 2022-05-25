import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<dynamic> _items = [
    {
      'title': 'Busca por palabras claves o experiencias',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    },
    {
      'title': 'Navega por listado de palabras claves',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    },
    {
      'title': 'Explora el directorio temático',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    }
  ];

  Future<List<dynamic>> _loadHowToSearch() async {
    return Future.delayed(const Duration(milliseconds: 1000), () => _items);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: AppTheme.backgroundColor.withOpacity(.25),
          leading: InkWell(
            onTap: () {
              Routemaster.of(context).pop();
            },
            borderRadius: BorderRadius.circular(360),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 28,
            ),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: _loadHowToSearch(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var _items = snapshot.data as List;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 72,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: _items.length,
                            itemBuilder: (BuildContext context, index) {
                              var item = _items[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 18),
                                padding: const EdgeInsets.only(bottom: 18),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: CupertinoColors.separator))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'].toString().toUpperCase(),
                                      // style: AppTheme.listItemTitleTextStyle,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppTheme.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      item['text'],
                                      // style: AppTheme.listItemBodyTextStyle,
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
