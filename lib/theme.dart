import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/utils/utils.dart';

class AppTheme {
  static final primary = HexColor("#141E30");
  static final accent = HexColor("#f94848");
  static final primaryLight = HexColor("#4282b8");
  static final backgroundColor = HexColor("#EBF1F4");

  static final ThemeData theme =
      ThemeData(primarySwatch: Utils.createMaterialColor(accent));
}
