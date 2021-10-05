import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widgets/carousel.dart';
import 'package:legalis/widgets/link.dart';

class Footer extends StatelessWidget {
  List<Widget> items = [
    Row(
      children: [
        Container(
          decoration: BoxDecoration(color: AppTheme.accentColor),
          width: 300,
          height: 200,
        ),
        Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Preguntas frecuentes",
              style: TextStyle(color: AppTheme.textColorLight),
            ),
            Text(
              "Autor, Fecha",
              style: TextStyle(color: AppTheme.accentColor),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  'my super long string d my super long string d my super long string d my super long string d my super long string d my super long string d',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ))
          ],
        ))
      ],
    )
  ];

  final _subscribeEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: AppTheme.blue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Carousel(items)],
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 100,
                      ),
                      Flexible(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 600),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MANTENTE ACTUALIZADO",
                                      style: TextStyle(
                                          color: AppTheme.textColorLight),
                                    ),
                                    Text("Subscribete a nuestro boletín",
                                        style: TextStyle(
                                            color: AppTheme.textColorLight)),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    CupertinoTextField(
                                      controller: _subscribeEmailController,
                                    ),
                                    Center(
                                      child: CupertinoButton(
                                          child: Text("SUBSCRIBETE"),
                                          onPressed: () => {}),
                                    )
                                  ],
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                      SizedBox(
                        height: 10,
                      ),
                      Link("Indice de gaceta"),
                    ],
                  )
                ],
              )),
            )
          ],
        ));
  }
}
