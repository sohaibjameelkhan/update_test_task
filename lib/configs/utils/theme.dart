import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData currentTheme(context) => Theme.of(context);

ColorScheme getColorScheme(context) => currentTheme(context).colorScheme;

TextStyle? fontW7S12(context) => currentTheme(context).textTheme.headline1;

TextStyle? fontW4S12(context) => currentTheme(context).textTheme.headline2;

TextStyle? fontW3S12(context) => currentTheme(context).textTheme.headline3;

TextStyle? fontTextField(context) => currentTheme(context).textTheme.headline3;

Color primaryColor(context) => currentTheme(context).primaryColor;

Color secondryColor(context) => getColorScheme(context).secondary;

Color acentColor() => Colors.white;

Color grayColor() => Colors.white;

class AppTheme {
  //
  static var themeData = ThemeData(
    useMaterial3: true,

    //fontFamily: GoogleFonts.inter(),
    dialogBackgroundColor: Colors.white,
    backgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.appcolor,
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.whitecolor),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.whitecolor),

    colorScheme:
        ColorScheme.fromSwatch(accentColor: AppColors.appcolor).copyWith(
      secondary: const Color(0xff70BC4E),

      //brightness: Brightness.dark,
    ),
    dialogTheme: const DialogTheme(backgroundColor: AppColors.appcolor),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    timePickerTheme:
        const TimePickerThemeData(backgroundColor: AppColors.whitecolor),
    appBarTheme: const AppBarTheme(
      color: Color(0xff70BC4E),
      elevation: 0.0,
      centerTitle: true,
    ),
    bottomAppBarColor: const Color(0xff70BC4E),
    hintColor: Colors.white,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Color(0xff70BC4E)),
    textTheme: TextTheme(
      headline1: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 28,
      ),
      //
      // fontWeight: FontWeight.w500,
      // fontFamily: 'Helvetica-Bold',
      // fontStyle: FontStyle.normal,
      // fontSize: 12,
      // overflow: TextOverflow.ellipsis),
      headline2: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
      headline3: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),

      headline4: GoogleFonts.inter(
        color: AppColors.textfieldColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 13,
      ),
    ),
  );

  static var themeDarkData = ThemeData(
    useMaterial3: true,

    //fontFamily: GoogleFonts.inter(),
    dialogBackgroundColor: Colors.white,
    backgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.appcolor,
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.whitecolor),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.whitecolor),

    colorScheme:
        ColorScheme.fromSwatch(accentColor: AppColors.appcolor).copyWith(
      secondary: const Color(0xff70BC4E),

      //brightness: Brightness.dark,
    ),
    dialogTheme: const DialogTheme(backgroundColor: AppColors.appcolor),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    timePickerTheme:
        const TimePickerThemeData(backgroundColor: AppColors.whitecolor),
    appBarTheme: const AppBarTheme(
      color: Color(0xff70BC4E),
      elevation: 0.0,
      centerTitle: true,
    ),
    bottomAppBarColor: const Color(0xff70BC4E),
    hintColor: Colors.white,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Color(0xff70BC4E)),
    textTheme: TextTheme(
      headline1: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 28,
      ),
      //
      // fontWeight: FontWeight.w500,
      // fontFamily: 'Helvetica-Bold',
      // fontStyle: FontStyle.normal,
      // fontSize: 12,
      // overflow: TextOverflow.ellipsis),
      headline2: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        fontStyle: FontStyle.normal,
      ),
      headline3: GoogleFonts.inter(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),

      headline4: GoogleFonts.inter(
        color: AppColors.textfieldColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 13,
      ),
    ),
  );
}
