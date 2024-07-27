import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextStyle() {
    return const TextStyle(
        fontSize: 19.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle boldHeadlineTextStyle() {
    return const TextStyle(
        fontSize: 26.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lightTextStyle() {
    return const TextStyle(
        fontSize: 18.0,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lightBoldTextStyle() {
    return const TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lightsemiTextStyle() {
    return const TextStyle(
        fontSize: 14.0,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
}
