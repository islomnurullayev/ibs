import 'package:flutter/cupertino.dart';
import 'package:ibs/theme/style.dart';

final theme = CupertinoThemeData(
  brightness: Style.appBrightness,
  primaryColor: Style.colors.primary,
  scaffoldBackgroundColor: Style.colors.white,
  barBackgroundColor: Style.colors.white,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(fontFamily: Style.fontFamily),
    navActionTextStyle: TextStyle(color: Style.colors.black),
    navTitleTextStyle: Style.headline6,
  ),
);
