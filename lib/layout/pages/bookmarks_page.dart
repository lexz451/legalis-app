import 'package:flutter/cupertino.dart';
import 'package:legalis/layout/widgets/normative_item.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final List<Normative> _normatives = [
    Normative(
        id: "kjkjkfdlkjdfowrngpzlx",
        name: 'Normativa #1',
        gazette: 'GOC-2021-266-O28',
        year: 2022,
        organism: 'Organismo #1',
        state: 'Activa',
        keywords: ['Keyword #1', 'Keyword #2'],
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        number: 12,
        normtype: "Ley",
        summary:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        tags: [])
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 64,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Mis favoritos".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppTheme.deepBlue),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                var item = _normatives[index];
                return NormativeItem(
                  normative: item,
                  onRemove: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Eliminar favorito"),
                            content: Text(
                                "Desea eliminar esta normativa de sus favoritos?"),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Cancelar"),
                                onPressed: () => Routemaster.of(context).pop(),
                              ),
                              CupertinoDialogAction(
                                child: Text("Eliminar"),
                                onPressed: () => Routemaster.of(context).pop(),
                                isDefaultAction: true,
                              ),
                            ],
                          );
                        });
                  },
                );
              }, childCount: _normatives.length)),
            )
          ],
        ),
      ),
    );
  }
}
