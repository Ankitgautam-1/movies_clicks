import 'package:flutter/material.dart';

Color themeColorSwitch(BuildContext context,
    {required Color darkColor, required Color lightColor}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  if (isDark) {
    return darkColor;
  } else {
    return lightColor;
  }
}
