import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData;

  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[Themes.LIGHT];
    }
    return _themeData;
  }

  setTheme(ThemeData theme) async {
    _themeData = theme;

    notifyListeners();
  }
}
