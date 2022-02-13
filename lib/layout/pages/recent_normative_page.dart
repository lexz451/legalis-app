import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/layout/widgets/normative_item.dart';
import 'package:legalis/model/gazette.dart';
import 'package:legalis/model/normative.dart';
import 'package:legalis/theme.dart';
import 'package:routemaster/routemaster.dart';

class RecentNormativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecentNormativePageState();
}

class _RecentNormativePageState extends State<RecentNormativePage> {
  Gazette _recent = Gazette(
      id: "goc-2022-ex13.pdf",
      name: "Gaceta Oficial No. 13 Extraordinaria de 2022",
      file: "goc-2022-ex13.pdf",
      type: "Extraordinaria",
      date: "02/01/22",
      number: 6,
      download_count: 8,
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Routemaster.of(context).pop(),
          child: Icon(
            CupertinoIcons.chevron_left,
            size: 20,
          ),
        ),
        middle: Text("Normativa reciente"),
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
                  style: AppTheme.errorTextStyle,
                ),
              );
            } else {
              var _gazette = snapshot.data as Gazette;
              var _normatives = _gazette.normatives;
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                      decoration: BoxDecoration(
                        color: CupertinoColors.quaternarySystemFill,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _gazette.name.toUpperCase(),
                            style: TextStyle(
                                color: AppTheme.deepBlue,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_gazette.type.toUpperCase(),
                                        style: TextStyle(
                                            //fontStyle: FontStyle.italic,
                                            color: AppTheme.textColorDark,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(_gazette.date,
                                        style: TextStyle(
                                            //fontStyle: FontStyle.italic,
                                            color: AppTheme.textColorDark,
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
                                    child:
                                        Icon(CupertinoIcons.arrow_down_circle),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      itemCount: _normatives.length,
                      itemBuilder: (context, index) {
                        var _normative = _normatives[index];
                        return NormativeItem(normative: _normative);
                      },
                    ))
                  ],
                ),
              );
              /*return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                      decoration: BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Título de la gaceta".toUpperCase(),
                            style: TextStyle(
                                color: AppTheme.deepBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("05/12/22",
                              style: TextStyle(
                                  //fontStyle: FontStyle.italic,
                                  color: AppTheme.textColorDark,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                    Flexible(
                        child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      itemCount: _normatives.length,
                      itemBuilder: (context, index) {
                        var _normative = _normatives[index];
                        var _keywords = _normative['keywords'] as List;
                        return Container(
                          padding: EdgeInsets.only(bottom: 12),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: CupertinoColors.separator))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _normative['title'],
                                style: TextStyle(
                                    color: AppTheme.accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                _normative['tematica'].toString().toUpperCase(),
                                style: TextStyle(
                                    color: AppTheme.deepBlue, fontSize: 12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                _normative['text'],
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppTheme.textColorDark),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Wrap(
                                spacing: 8,
                                children: _keywords
                                    .map((e) => Text(
                                          e,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: AppTheme.deepBlue),
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );*/
            }
          }
        },
      ),
    );
  }
}
