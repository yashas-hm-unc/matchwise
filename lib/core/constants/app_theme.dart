import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchwise/core/constants/app_colors.dart';
import 'package:resize/resize.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
  primaryColor: carolinaBlue,
  scaffoldBackgroundColor: white,
  textTheme: GoogleFonts.latoTextTheme(
    Theme.of(context).textTheme.apply(
      bodyColor: black,
      displayColor: black,
    ),
  ),
  useMaterial3: false,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: carolinaBlue,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 5.sp,
    iconTheme: const IconThemeData(
      color: black,
    ),
    backgroundColor: white,
    titleTextStyle: GoogleFonts.pacifico(
      fontSize: 30.sp,
      color: black,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: carolinaBlue,
    primary: carolinaBlue,
    secondary: carolinaBlue2,
    tertiary: navy,
    shadow: black,
    brightness: Brightness.light,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: carolinaBlue2,
    cursorColor: carolinaBlue2,
    selectionColor: carolinaBlue2.withOpacity(0.3),
  ),
);