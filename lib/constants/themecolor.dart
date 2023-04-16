import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE8EAF6),
  100: Color(0xFFC5CBE9),
  200: Color(0xFF9FA8DA),
  300: Color(0xFF7985CB),
  400: Color(0xFF5C6BC0),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF394AAE),
  700: Color(0xFF3140A5),
  800: Color(0xFF29379D),
  900: Color(0xFF1B278D),
});
const int _primaryPrimaryValue = 0xFF3F51B5;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFC6CBFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFF606EFF),
  700: Color(0xFF4757FF),
});
const int _primaryAccentValue = 0xFF939DFF;
