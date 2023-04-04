import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class CustomColors {
  Color backgroundColor = HexColor("#232946");
  Color headlineColor = HexColor("#fffffe");
  Color paragraphColor = HexColor("#b8c1ec");
  Color buttonColor = HexColor("#eebbc3");
  Color buttonTextColor = HexColor("#232946");
  Color borderColor = HexColor("#121629");
}
