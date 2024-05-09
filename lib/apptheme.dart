import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hawk/appcolors.dart';

class AppTheme {
  static final dark = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkCyan,
      background: AppColors.darkBg,
    ),
    textTheme: GoogleFonts.nunitoTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
    ),
  );
}
