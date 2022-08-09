import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardNotes extends StatelessWidget {
  CardNotes(
      {Key? key,
      required this.content,
      required this.ontap,
      required this.title})
      : super(key: key);
  String title;
  String content;
  void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  "asset/logo.png",
                  width: 100,
                  height: 100,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    "$title",
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    "$content",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
