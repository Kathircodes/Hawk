import 'package:flutter/material.dart';

class AppGradients {
  static const List<LinearGradient> cardBg = [
    LinearGradient(
      colors: [
        Color(0xFF00506B),
        Color(0xFF00212E),
        Color(0xFF002B48),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    LinearGradient(
      colors: [
        Color(0x62005B82), // opacity 39
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  static const List<LinearGradient> imageCardBg = [
    LinearGradient(
      colors: [
        Color(0xA8036685), // opacity 66
        Color(0xA8051026), // opacity 66
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color(0x62005B82), // opacity 39
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  static const List<LinearGradient> profileCardBg = [
    LinearGradient(
      colors: [
        Color(0xFF036685),
        Color(0xFF051026),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color(0x62005B82), // opacity 39
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    LinearGradient(
      colors: [
        Color(0x2F00FFFF), // opacity 19
        Colors.transparent,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    ...imageCardBg
  ];

  static const LinearGradient screenBg = LinearGradient(
    colors: [
      Color(0xFF064A62),
      Color(0xFF001117),
    ],
    begin: Alignment.topRight,
    end: Alignment.center,
  );
}
