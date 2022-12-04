import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();
  static final ColorConstants _instance = ColorConstants._();
  factory ColorConstants() => _instance;
  Color primaryColor = const Color.fromRGBO(96, 80, 201, 1);
  Color primaryDarkColor = const Color.fromRGBO(96, 80, 201, 1);
  Color lightBackgroundColor = Colors.white;
  Color darkBackgroundColor = const Color(0xFF1F2034);
  Color primaryTextLight = Colors.black;
  Color primaryTextDark = Colors.white;
  Color accentColor = const Color.fromRGBO(96, 80, 201, 1);
}
