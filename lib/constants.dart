import 'package:flutter/material.dart';

class Constants {

  //////////////////// Colors

  // Use this website to generate other color palette themes: http://mcg.mbitson.com/#!?mcgpalette0=%235da2d6
  static const MaterialColor kToDark = const MaterialColor(
    0xff4a148c, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: Color.fromRGBO(74, 20, 140, 0.1),
      100: Color.fromRGBO(74, 20, 140, 0.2),
      200: Color.fromRGBO(74, 20, 140, 0.3),
      300: Color.fromRGBO(74, 20, 140, 0.4),
      400: Color.fromRGBO(74, 20, 140, 0.5),
      500: Color.fromRGBO(74, 20, 140, 0.6),
      600: Color.fromRGBO(74, 20, 140, 0.7),
      700: Color.fromRGBO(74, 20, 140, 0.8),
      800: Color.fromRGBO(74, 20, 140, 0.9),
      900: Color.fromRGBO(74, 20, 140, 1.0),
    },
  );

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const background1 = Color(0xffffffff);
  static const background2 = Color(0xfff5f5f6);

  // Variations of the first color
  static const color1Light = Color(0xff63d7cb);
  static const color1 = Color(0xff25a59a);
  static const color1Dark = Color(0xff00756c);

  // Variations of the second color
  static const color2Light = Color(0xff7c43bd);
  static const color2 = Color(0xff4a148c);
  static const color2Dark = Color(0xff12005e);


  //////////////////// Numbers
  static const maxUsernameLength = 50;
  static const maxPasswordLength = 50;


}
