import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'OpenSans',
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'OpenSans',
  );
}
