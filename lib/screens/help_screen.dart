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
    return Future.delayed(Duration(milliseconds: 1000), () => _items);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Colors.transparent,
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
        child: FutureBuilder(
          future: _loadHowToSearch(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else {
                var _items = snapshot.data as List;
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Cómo buscar",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16),
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, index) {
                          var item = _items[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 18),
                            padding: EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
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
                                SizedBox(
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
            }
          },
        ),
      ),
    );
  }
}
