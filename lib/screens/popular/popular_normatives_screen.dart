import 'package:flutter/cupertino.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:routemaster/routemaster.dart';

class PopularNormativeScreen extends StatefulWidget {
  const PopularNormativeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularNormativeScreenState createState() => _PopularNormativeScreenState();
}

class _PopularNormativeScreenState extends State<PopularNormativeScreen> {
  static final List<Normative> _normatives = [
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
    return Future.delayed(const Duration(milliseconds: 500), () => _normatives);
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
        middle: const Text(
          "Normativas populares",
        ),
      ),
      child: FutureBuilder(
        future: _popularNormatives(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              var normatives = snapshot.data as List<Normative>;
              return Container(
                padding: const EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: normatives.length,
                    itemBuilder: (context, index) {
                      var normative = normatives[index];
                      return NormativeItem(normative: normative);
                    }),
              );
            }
          }
        },
      ),
    );
  }
}
