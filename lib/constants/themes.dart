import 'package:flutter/material.dart';
import 'package:vegas_lit/constants/palette.dart';

class Themes {
  static final ThemeData light = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Palette.darkGrey,
    primaryColor: Palette.darkGrey,
    primaryColorLight: Palette.lightGrey,
    primaryColorDark: Palette.darkGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
