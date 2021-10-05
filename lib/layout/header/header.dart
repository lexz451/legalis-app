import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/layout/header/widgets/search.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widgets/link.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: HexColor("#123970")),
      child: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("images/logo.png"),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SearchWidget()
                ],
              )),
              Column()
            ],
          )),
          Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppTheme.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: AppTheme.borderLight),
                            left: BorderSide(color: AppTheme.borderLight))),
                    height: 65,
                    width: 200,
                    child: Center(child: Link("BUSQUEDA AVANZADA"))),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: AppTheme.borderLight))),
                    height: 65,
                    width: 200,
                    child: Center(child: Link("DIRECTORIO TEMATICO"))),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: AppTheme.borderLight))),
                    height: 65,
                    width: 200,
                    child: Center(child: Link("PALABRA CLAVE"))),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: AppTheme.borderLight))),
                    height: 65,
                    width: 200,
                    child: Center(child: Link("COMO BUSCAR")))
              ],
            ),
          )
        ],
      ),
    );
  }
}
