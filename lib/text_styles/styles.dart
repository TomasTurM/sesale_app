import 'package:flutter/material.dart';
import 'dart:ui';

TextStyle titleStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 50.0,
  );
}

TextStyle subtitlesStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32.0,
  );
}

TextStyle normalTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 21.0
  );
}

TextStyle chipsTextStyle() {
  return TextStyle(
    fontSize: 25.0, 
  );
}

TextStyle drawerTitleTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    color: Color.fromRGBO(255, 255, 255, 20),
  );
}