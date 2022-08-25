import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm(
      {Key? key,
      required this.hinttype,
      required this.iname,
      required this.mycontroller,
      required this.valid})
      : super(key: key);
  String hinttype = "";
  String iconname = "";
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  Widget iname = const Icon(Icons.person);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valid,
      controller: mycontroller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        hintText: hinttype,
        suffixIcon: iname,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
