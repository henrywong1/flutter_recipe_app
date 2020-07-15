import 'package:flutter/material.dart';

enum Themes { LIGHT, DARK }

String enumName(Themes enums) {
  return enums.toString().split('.')[1];
}

final appThemeData = {
  Themes.LIGHT: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      backgroundColor: Colors.white),
  Themes.DARK: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      backgroundColor: Colors.grey[850])
};
