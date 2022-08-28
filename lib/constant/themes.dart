import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color teal = Colors.red;
const primaryClr = teal;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: teal,
      primarySwatch: Colors.red,
      brightness: Brightness.light);
  static final dark =
      ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark);
}
