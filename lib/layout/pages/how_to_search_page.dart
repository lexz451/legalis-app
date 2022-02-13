import 'package:flutter/cupertino.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class HowToSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HowToSearchPageState();
}

class _HowToSearchPageState extends State<HowToSearchPage> {
  final List<dynamic> _items = [
    {
      'title': 'Busca por palabras claves o experiencias',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias . Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias '
    },
    {
      'title': 'Navega por listado de palabras claves',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias .'
    },
    {
      'title': 'Explora el directorio temático',
      'text':
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias .'
    }
  ];

  Future<List<dynamic>> _loadHowToSearch() async {
    return Future.delayed(Duration(milliseconds: 1000), () => _items);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            onTap: () => Routemaster.of(context).pop(),
            child: Icon(
              CupertinoIcons.chevron_left,
              size: 20,
            ),
          ),
          middle: Text("Como buscar"),
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
                    style: AppTheme.errorTextStyle,
                  ),
                );
              } else {
                var _items = snapshot.data as List;
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
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
                                      style: AppTheme.listItemTitleTextStyle,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      item['text'],
                                      style: AppTheme.listItemBodyTextStyle,
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                ),
                              );
                            }))
                  ],
                );
              }
            }
          },
        ));
  }
}
