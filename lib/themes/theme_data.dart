import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_clicks/utils/custom_fonts.dart';

import 'color_constants.dart';

class ThemeConfig {
  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: ColorConstants().darkBackgroundColor,
        primaryColor: ColorConstants().primaryColor,
        cardBackground: ColorConstants().darkBackgroundColor,
        primaryText: ColorConstants().primaryTextDark,
        secondaryText: ColorConstants().primaryTextLight,
        accentColor: ColorConstants().accentColor,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: ColorConstants().darkBackgroundColor,
        disabled: ColorConstants().darkBackgroundColor,
        error: Colors.red,
      );

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: ColorConstants().lightBackgroundColor,
        primaryColor: ColorConstants().primaryColor,
        cardBackground: ColorConstants().lightBackgroundColor,
        primaryText: ColorConstants().primaryTextLight,
        secondaryText: ColorConstants().primaryTextDark,
        accentColor: ColorConstants().accentColor,
        divider: ColorConstants().lightBackgroundColor,
        buttonBackground: Colors.black38,
        buttonText: ColorConstants().lightBackgroundColor,
        disabled: ColorConstants().lightBackgroundColor,
        error: Colors.red,
      );

  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    required Color secondaryText,
    required Color accentColor,
    required Color divider,
    required Color buttonBackground,
    required Color buttonText,
    required Color cardBackground,
    required Color disabled,
    required Color error,
    required Color primaryColor,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      fontFamily: 'Poppins',
      brightness: brightness,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              )),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(18.5)))),
      backgroundColor: background,
      primaryColor: primaryColor,
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: brightness),
        color: cardBackground,
        iconTheme: IconThemeData(
          color: secondaryText,
        ),
        toolbarTextStyle: TextTheme(
          bodyText1: baseTextTheme.bodyText1?.copyWith(
            color: secondaryText,
            fontSize: 18,
          ),
        ).bodyText2,
        titleTextStyle: TextTheme(
          bodyText1: baseTextTheme.bodyText1?.copyWith(
            color: secondaryText,
            fontSize: 18,
          ),
        ).headline6,
      ),
      iconTheme: IconThemeData(
        color: secondaryText,
        size: 16.0,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          secondary: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryText,
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: TextTheme(
        headline1: baseTextTheme.headline1?.copyWith(
          color: primaryText,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
        headline2: baseTextTheme.headline2?.copyWith(
          color: primaryText,
          fontSize: 22,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
        headline3: baseTextTheme.headline3?.copyWith(
          color: secondaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headline4: baseTextTheme.headline4?.copyWith(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        headline5: baseTextTheme.headline5?.copyWith(
          color: primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        headline6: baseTextTheme.headline6?.copyWith(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        bodyText1: baseTextTheme.bodyText1?.copyWith(
          color: secondaryText,
          fontSize: 14,
        ),
        bodyText2: baseTextTheme.bodyText2?.copyWith(
          color: primaryText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        button: baseTextTheme.button?.copyWith(
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        caption: baseTextTheme.caption?.copyWith(
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
        ),
        overline: baseTextTheme.overline?.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: baseTextTheme.subtitle1?.copyWith(
          color: primaryText,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        subtitle2: baseTextTheme.subtitle2?.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: accentColor, brightness: brightness),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
      ),
    );
  }
}

ThemeData darkTheme() {
  return ThemeData(
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        actionTextColor: Colors.deepPurpleAccent.shade700,
        contentTextStyle: const TextStyle(
          color: Colors.white,
        )),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
           systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        centerTitle: true,
        color: ColorConstants().lightBackgroundColor,
        toolbarTextStyle:
            const TextTheme(labelMedium: TextStyle(color: Colors.white))
                .bodyText2,
        titleTextStyle: const TextStyle(color: Colors.white)),
    fontFamily: "Poppins",
    brightness: ThemeConfig.darkTheme.brightness,
    canvasColor: ThemeConfig.darkTheme.backgroundColor,
    cardColor: ThemeConfig.darkTheme.backgroundColor,
    dividerColor: ThemeConfig.darkTheme.dividerColor,
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    dividerTheme: DividerThemeData(
      color: ThemeConfig.darkTheme.dividerColor,
      space: 1,
      thickness: 1,
    ),
    cardTheme: CardTheme(
      color: ThemeConfig.darkTheme.backgroundColor,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(18.5)))),
    backgroundColor: ThemeConfig.darkTheme.backgroundColor,
    primaryColor: ThemeConfig.darkTheme.primaryColor,
    toggleableActiveColor: ThemeConfig.darkTheme.primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 16.0,
    ),
    errorColor: ThemeConfig.darkTheme.errorColor,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme(
        brightness: ThemeConfig.darkTheme.brightness,
        primary: ThemeConfig.darkTheme.primaryColor,
        secondary: ThemeConfig.darkTheme.primaryColorDark,
        surface: ThemeConfig.darkTheme.backgroundColor,
        background: ThemeConfig.darkTheme.backgroundColor,
        error: ThemeConfig.darkTheme.errorColor,
        onPrimary: ThemeConfig.darkTheme.primaryColor,
        onSecondary: ThemeConfig.darkTheme.primaryColor,
        onSurface: ThemeConfig.darkTheme.primaryColor,
        onBackground: ThemeConfig.darkTheme.primaryColor,
        onError: ThemeConfig.darkTheme.primaryColor,
      ),
      padding: const EdgeInsets.all(16.0),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: ThemeConfig.darkTheme.brightness,
      primaryColor: ThemeConfig.darkTheme.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(color: ThemeConfig.darkTheme.errorColor),
      labelStyle: TextStyle(
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: ThemeConfig.darkTheme.primaryColor.withOpacity(0.5),
      ),
      hintStyle: TextStyle(
        color: ThemeConfig.darkTheme.selectedRowColor,
        fontSize: 13.0,
        fontWeight: FontWeight.w300,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ThemeConfig.darkTheme.selectedRowColor,
        brightness: ThemeConfig.darkTheme.brightness),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeConfig.darkTheme.primaryColor,
      selectionColor: ThemeConfig.darkTheme.selectedRowColor,
      selectionHandleColor: ThemeConfig.darkTheme.secondaryHeaderColor,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        actionTextColor: Colors.deepPurpleAccent.shade700,
        contentTextStyle: const TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: true,
        color: ColorConstants().lightBackgroundColor,
        toolbarTextStyle:
            const TextTheme(labelMedium: TextStyle(color: Colors.black))
                .bodyText2,
        titleTextStyle: const TextStyle(color: Colors.black)),
    fontFamily: "Poppins",
    brightness: ThemeConfig.lightTheme.brightness,
    canvasColor: ThemeConfig.lightTheme.backgroundColor,
    cardColor: ThemeConfig.lightTheme.backgroundColor,
    dividerColor: ThemeConfig.lightTheme.dividerColor,
    dividerTheme: DividerThemeData(
      color: ThemeConfig.lightTheme.dividerColor,
      space: 1,
      thickness: 1,
    ),
    cardTheme: CardTheme(
      color: ThemeConfig.lightTheme.backgroundColor,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(18.5)))),
    backgroundColor: ThemeConfig.lightTheme.backgroundColor,
    primaryColor: ThemeConfig.lightTheme.primaryColor,
    toggleableActiveColor: ThemeConfig.lightTheme.primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 16.0,
    ),
    errorColor: ThemeConfig.lightTheme.errorColor,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme(
        brightness: ThemeConfig.lightTheme.brightness,
        primary: ThemeConfig.lightTheme.primaryColor,
        secondary: ThemeConfig.lightTheme.primaryColorDark,
        surface: ThemeConfig.lightTheme.backgroundColor,
        background: ThemeConfig.lightTheme.backgroundColor,
        error: ThemeConfig.lightTheme.errorColor,
        onPrimary: ThemeConfig.lightTheme.primaryColor,
        onSecondary: ThemeConfig.lightTheme.primaryColor,
        onSurface: ThemeConfig.lightTheme.primaryColor,
        onBackground: ThemeConfig.lightTheme.primaryColor,
        onError: ThemeConfig.lightTheme.primaryColor,
      ),
      padding: const EdgeInsets.all(16.0),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: ThemeConfig.lightTheme.brightness,
      primaryColor: ThemeConfig.lightTheme.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(color: ThemeConfig.lightTheme.errorColor),
      labelStyle: TextStyle(
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: ThemeConfig.lightTheme.primaryColor.withOpacity(0.5),
      ),
      hintStyle: TextStyle(
        color: ThemeConfig.lightTheme.selectedRowColor,
        fontSize: 13.0,
        fontWeight: FontWeight.w300,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ThemeConfig.lightTheme.selectedRowColor,
        brightness: ThemeConfig.lightTheme.brightness),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ThemeConfig.lightTheme.primaryColor,
      selectionColor: ThemeConfig.lightTheme.selectedRowColor,
      selectionHandleColor: ThemeConfig.lightTheme.secondaryHeaderColor,
    ),
  );
}
