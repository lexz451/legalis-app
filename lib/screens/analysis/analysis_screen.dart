import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final _content = [
    {
      'title': 'Preguntas frecuentes',
      'text':
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'
    },
    {
      'title': 'Preguntas frecuentes',
      'text':
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'
    }
  ];

  Future<dynamic> _analysisContent() async {
    return Future.delayed(const Duration(milliseconds: 500), () => _content);
  }

  Widget _analysisCard(title, content) {
    return ExpandableNotifier(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: AppTheme.primary.withOpacity(.5)),
        child: Column(
          children: [
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                    useInkWell: false,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    hasIcon: false,
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true),
                header: Text(
                  title.toString().toUpperCase(),
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                collapsed: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 12, top: 12),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CupertinoColors.separator
                                      .withOpacity(.2)))),
                      child: Text(
                        content,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Center(
                      heightFactor: 1.15,
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        size: 16,
                        color: CupertinoColors.separator.withOpacity(.5),
                      ),
                    )
                  ],
                ),
                expanded: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 12, top: 12),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CupertinoColors.separator
                                      .withOpacity(.2)))),
                      child: Text(
                        content,
                        softWrap: true,
                      ),
                    ),
                    Center(
                      heightFactor: 1.15,
                      child: Icon(
                        CupertinoIcons.chevron_up,
                        size: 16,
                        color: CupertinoColors.separator.withOpacity(.5),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Routemaster.of(context).pop(),
          child: const Icon(
            CupertinoIcons.chevron_left,
            size: 20,
          ),
        ),
        middle: const Text("Análisis"),
      ),
      child: FutureBuilder(
        future: _analysisContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              var content = snapshot.data as List;
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  var item = content[index];
                  return _analysisCard(item['title'], item['text']);
                },
              );
            }
          }
        },
      ),
    );
  }
}
