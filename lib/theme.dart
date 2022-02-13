import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static double borderRadius = 4;

  static final backgroundColor = HexColor("#fafafa");
  static final backgroundSurfaceColor = HexColor("#e6e6e6");
  static final blue = HexColor("#74B1E1");
  static final deepBlue = HexColor("#11315e");
  static final textColorLight = HexColor("#fafafa");
  static final textColorDark = HexColor("#212121");
  static final textColorError = CupertinoColors.systemRed;
  static final accentColor = HexColor("#f94848");
  static final borderLight = HexColor("#fafafa").withOpacity(0.1);
  static final searchBoxBackground = HexColor("#fafafa").withOpacity(0.25);
  static final errorTextStyle = TextStyle(color: textColorError);
  static final listItemTitleTextStyle =
      TextStyle(color: deepBlue, fontSize: 14, fontWeight: FontWeight.bold);
  static final listItemBodyTextStyle = TextStyle(
      color: textColorDark, fontSize: 12, fontWeight: FontWeight.normal);
  static final appBarTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentColor);

  static CupertinoThemeData? get themeData {
    return CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: accentColor,
        barBackgroundColor: HexColor("#0C264A"),
        //scaffoldBackgroundColor: backgroundColor,
        textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(fontFamily: "Inter"),
            navActionTextStyle: TextStyle(
                fontFamily: "Inter", color: accentColor, fontSize: 16),
            navTitleTextStyle: TextStyle(
                fontFamily: "Inter", fontSize: 18, fontWeight: FontWeight.w700),
            navLargeTitleTextStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: blue)));
  }
}
