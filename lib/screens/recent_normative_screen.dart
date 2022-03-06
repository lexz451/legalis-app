import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/normative_item.dart';
import 'package:routemaster/routemaster.dart';

class RecentNormative extends StatefulWidget {
  const RecentNormative({Key? key}) : super(key: key);

  @override
  State<RecentNormative> createState() => _RecentNormativeState();
}

class _RecentNormativeState extends State<RecentNormative> {
  Gazette _recent = Gazette(
      id: "goc-2022-ex13.pdf",
      name: "Gaceta Oficial No. 13 Extraordinaria de 2022",
      file: "goc-2022-ex13.pdf",
      type: "Extraordinaria",
      date: "02/01/22",
      number: 6,
      downloadCount: 8,
      normatives: [
        Normative(
            id: "2d33860c07780b4081f9287580f0c0dd210a09cc",
            name:
                "Resolución 2 de 2022 de Ministerio del Comercio Exterior y la Inversión Extranjera",
            text: "",
            summary:
                "Autoriza la inscripción de la oficina de representación de la compañía portuguesa VULCAL-VULCANIZACOES E LUBRIFICANTES, S.A. en el Registro Nacional de Representaciones Comerciales Ex­tranjeras.",
            year: 0,
            normtype: "Resolución"),
        Normative(
            id: "6ebbbdae6cdeb4ce0a98b89e6af521fa43048475",
            name:
                "Resolución 15 de 2022 de Ministerio del Comercio Exterior y la Inversión Extranjera",
            summary:
                "Autoriza la inscripción de la oficina de representación de la compañía panameña GLIOLA, S.A. en el Registro Nacional de Representaciones Comerciales Ex­tranjeras.",
            normtype: "Resolución")
      ]);

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _recentNormative() async {
    return Future.delayed(Duration(milliseconds: 500), () => _recent);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: AppTheme.backgroundColor.withOpacity(.75),
          leading: InkWell(
            onTap: () {
              Routemaster.of(context).pop();
            },
            borderRadius: BorderRadius.circular(360),
            child: Icon(
              Icons.arrow_back_rounded,
              size: 28,
              color: AppTheme.primary,
            ),
          ),
        ),
        child: FutureBuilder(
          future: _recentNormative(),
          builder: (context, snapshot) {
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
                var _gazette = snapshot.data as Gazette;
                var _normatives = _gazette.normatives;
                return Material(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 68,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 18),
                          decoration: BoxDecoration(
                            color: CupertinoColors.quaternarySystemFill,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _gazette.name?.toUpperCase() ?? "!",
                                style: TextStyle(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _gazette.type?.toUpperCase() ?? "-",
                                            style: TextStyle(
                                                //fontStyle: FontStyle.italic,

                                                fontWeight: FontWeight.w400)),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(_gazette.date?.toString() ?? "-",
                                            style: TextStyle(
                                                //fontStyle: FontStyle.italic,

                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          child: Icon(CupertinoIcons.doc)),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                            CupertinoIcons.arrow_down_circle),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Flexible(
                            child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          itemCount: _normatives?.length ?? 0,
                          itemBuilder: (context, index) {
                            var _normative = _normatives?[index];
                            return NormativeItem(normative: _normative!);
                          },
                        ))
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
