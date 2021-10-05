import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static double borderRadius = 4;

  static final backgroundColor = HexColor("#fafafa");
  static final blue = HexColor("#17468A");
  static final textColorLight = HexColor("#fafafa");
  static final textColorDark = HexColor("#212121");
  static final accentColor = HexColor("#CD3836");
  static final borderLight = HexColor("#fafafa").withOpacity(0.1);

  static CupertinoThemeData? get themeData {
    return CupertinoThemeData();
  }
}
