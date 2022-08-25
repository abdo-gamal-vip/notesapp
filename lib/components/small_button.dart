// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Smallbutton extends StatelessWidget {
  Smallbutton({Key? key, required this.txt, required this.onPreased})
      : super(key: key);
  String txt = "";
  void Function() onPreased;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue, shadowColor: Colors.blueAccent),
        onPressed: onPreased,
        child: Text(
          txt,
          style: const TextStyle(fontSize: 18),
        ));
  }
}
