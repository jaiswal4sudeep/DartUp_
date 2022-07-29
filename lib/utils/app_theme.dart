import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_constant.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    primaryColor: AppConstant.primaryColor,
    backgroundColor: AppConstant.backgroundColor,
    iconTheme: const IconThemeData(
      color: AppConstant.titlecolor,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppConstant.titlecolor,
      ),
      backgroundColor: AppConstant.backgroundColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppConstant.titlecolor,
        size: 16.sp,
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppConstant.backgroundColor,
    cardColor: AppConstant.backgroundColor,
    unselectedWidgetColor: Colors.black45,
    dividerColor: AppConstant.titlecolor,
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
      ),
      headline3: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      headline5: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      headline6: GoogleFonts.montserrat(
        color: AppConstant.titlecolor,
        fontSize: 8.sp,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: AppConstant.subtitlecolor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: GoogleFonts.montserrat(
        color: AppConstant.subtitlecolor,
        fontSize: 8.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
