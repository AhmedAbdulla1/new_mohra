import 'package:flutter/material.dart';

class ThemeText {
  // bodyText1
  static TextStyle? bodyText1(BuildContext ctx) {
    return Theme.of(ctx).textTheme.bodyLarge;
  }

  // bodyText2
  static TextStyle? bodyText2(BuildContext ctx) {
    return Theme.of(ctx).textTheme.bodyMedium;
  }

  // button
  static TextStyle? button(BuildContext ctx) {
    return Theme.of(ctx).textTheme.labelLarge;
  }

  // caption
  static TextStyle? caption(BuildContext ctx) {
    return Theme.of(ctx).textTheme.bodySmall;
  }

  // headline1
  static TextStyle? headline1(BuildContext ctx) {
    return Theme.of(ctx).textTheme.displayLarge;
  }

  // headline2
  static TextStyle? headline2(BuildContext ctx) {
    return Theme.of(ctx).textTheme.displayMedium;
  }

  // headline3
  static TextStyle? headline3(BuildContext ctx) {
    return Theme.of(ctx).textTheme.displaySmall;
  }

  // headline4
  static TextStyle? headline4(BuildContext ctx) {
    return Theme.of(ctx).textTheme.headlineMedium;
  }

  // headline5
  static TextStyle? headline5(BuildContext ctx) {
    return Theme.of(ctx).textTheme.headlineSmall;
  }

  // headline6
  static TextStyle? headline6(BuildContext ctx) {
    return Theme.of(ctx).textTheme.titleLarge;
  }

  // overline
  static TextStyle? overline(BuildContext ctx) {
    return Theme.of(ctx).textTheme.labelSmall;
  }

  // subtitle1
  static TextStyle? subtitle1(BuildContext ctx) {
    return Theme.of(ctx).textTheme.titleMedium;
  }

  // subtitle2
  static TextStyle? subtitle2(BuildContext ctx) {
    return Theme.of(ctx).textTheme.titleSmall;
  }
}
