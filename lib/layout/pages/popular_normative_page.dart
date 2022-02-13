import 'package:flutter/cupertino.dart';
import 'package:legalis/layout/widgets/normative_item.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class PopularNormativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PopularNormativePageState();
}

class _PopularNormativePageState extends State<PopularNormativePage> {
  static List<Normative> _normatives = [
    Normative(
      id: "b23fa0a01005c7230b8ef68b91197d41cb6896f5",
      name: "Nombramiento de Manuel Pozo Nuñez como Embajador",
      summary:
          "Nombra como Embajador Extraordinario y Plenipotenciario de la República de Cuba en Mongolia a Manuel Pozo Núñez.",
      organism: "Consejo de Estado",
      state: "Vigente",
      keywords: ["nombramiento", "Embajador"],
      year: 1900,
      normtype: "Acuerdo",
      number: -1,
      tags: [],
    ),
    Normative(
      id: "b23fa0a01005c7230b8ef68b91197d41cb6896f5",
      name: "Nombramiento de Manuel Pozo Nuñez como Embajador",
      summary:
          "Nombra como Embajador Extraordinario y Plenipotenciario de la República de Cuba en Mongolia a Manuel Pozo Núñez.",
      organism: "Consejo de Estado",
      state: "Vigente",
      keywords: ["nombramiento", "Embajador"],
      year: 1900,
      normtype: "Acuerdo",
      number: -1,
      tags: [],
    ),
    Normative(
      id: "b23fa0a01005c7230b8ef68b91197d41cb6896f5",
      name: "Nombramiento de Manuel Pozo Nuñez como Embajador",
      summary:
          "Nombra como Embajador Extraordinario y Plenipotenciario de la República de Cuba en Mongolia a Manuel Pozo Núñez.",
      organism: "Consejo de Estado",
      state: "Vigente",
      keywords: ["nombramiento", "Embajador"],
      year: 1900,
      normtype: "Acuerdo",
      number: -1,
      tags: [],
    )
  ];

  Future<List<Normative>> _popularNormatives() async {
    return Future.delayed(Duration(milliseconds: 500), () => _normatives);
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
        middle: Text(
          "Normativas populares",
        ),
      ),
      child: FutureBuilder(
        future: _popularNormatives(),
        builder: (context, snapshot) {
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
              var _normatives = snapshot.data as List<Normative>;
              return Container(
                padding: EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8,
                        ),
                    itemCount: _normatives.length,
                    itemBuilder: (context, index) {
                      var _normative = _normatives[index];
                      return NormativeItem(normative: _normative);
                    }),
              );
            }
          }
        },
      ),
    );
  }
}
