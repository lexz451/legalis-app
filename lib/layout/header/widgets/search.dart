import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/theme.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _searchTextController,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              decoration: BoxDecoration(
                color: HexColor("#ffffff").withOpacity(.2),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: .5, color: CupertinoColors.white)),
            child: GestureDetector(
              child: Icon(
                CupertinoIcons.search,
                size: 22,
                color: CupertinoColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
