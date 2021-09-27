import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/layout/header/widgets/search.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(color: HexColor("#123970")),
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
      ),
    );
  }
}
