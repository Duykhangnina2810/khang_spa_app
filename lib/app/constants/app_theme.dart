// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Màu chính
  static const Color COLOR_PRIMARY = Color(0xFF0870B8);
  static const Color COLOR_ACCENT = Color(0xFF0870B8);
  static const Color COLOR_XANH_REU_DAM = Color(0xFF1C292A);
  static const Color COLOR_XANH_REU_NHAT = Color(0xFF293F41);
  static const Color COLOR_VANG_NAU = Color(0xFFB28D2A);
  static const Color COLOR_VANG_COM = Color(0xFFF9F77B);
  static const Color COLOR_VANG_CAT_NHAT = Color(0xFFC4BCA5);
  static const Color COLOR_TRANG = Color(0xFFFFFFFF);
  static const LinearGradient COLOR_VANG_ANH_KIM = LinearGradient(begin: Alignment(0.0, 0.0), end: Alignment(0.937, -0.35), colors: [
    Color(0xffF8F67A),
    Color(0xffF6EF5A),
    Color(0xffF4DD47),
    Color(0xffC2A131),
    Color(0xff92651D),
    Color(0xffC6A837),
    Color(0xffF6EB59),
    Color(0xffF9F678),
    Color(0xffF9F899),
    Color(0xffF9F678),
    Color(0xffF6EB59),
    Color(0xffCCA134),
    Color(0xff9F591D)
  ], stops: [
    0.2436,
    0.4692,
    0.6601,
    0.8162,
    1.0938,
    1.3194,
    1.4409,
    1.5103,
    1.5797,
    1.6317,
    1.6838,
    1.84,
    1.9784,
  ]);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.COLOR_XANH_REU_DAM,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.COLOR_XANH_REU_DAM,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.COLOR_VANG_CAT_NHAT, size: 20),
        titleSpacing: 0,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.COLOR_PRIMARY,
      textTheme: GoogleFonts.mulishTextTheme(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.COLOR_ACCENT),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)), shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))), backgroundColor: MaterialStateProperty.all<Color>(AppColors.COLOR_ACCENT))),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(Colors.grey),
        thumbColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none), filled: true, fillColor: Colors.grey.withOpacity(0.1)),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)), shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))), backgroundColor: MaterialStateProperty.all<Color>(Colors.white), foregroundColor: MaterialStateProperty.all<Color>(Colors.black), overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
    );
  }
}
