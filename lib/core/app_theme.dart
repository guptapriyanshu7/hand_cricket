import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFD4B052);
  static const Color secondaryGold = Color(0xFFEBCC7C);
  static const Color crimsonRed = Color(0xFFC42C31);
  static const Color lightCrimson = Color(0xFFEB3E43);

  static ThemeData get theme => ThemeData.dark().copyWith(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
        backgroundColor: Colors.orange,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [primaryGold, secondaryGold],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get redGradient => const LinearGradient(
    colors: [crimsonRed, lightCrimson],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get blueGreyGradientLtr => LinearGradient(
    colors: [Colors.blueGrey[900]!, Colors.blueGrey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get blueGreyGradientRtl => LinearGradient(
    colors: [Colors.blueGrey[900]!, Colors.blueGrey],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static LinearGradient get blueGradient => LinearGradient(
    colors: [Colors.white, const Color(0xFF46C0FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get lightRedGradient => LinearGradient(
    colors: [Colors.white, const Color(0xFFF56565)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static RadialGradient get goldRadialGradient =>
      const RadialGradient(radius: 1.5, colors: [secondaryGold, primaryGold]);
}
