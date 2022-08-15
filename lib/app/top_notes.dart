import 'package:flutter/material.dart';
import 'package:notesapp/constant/linkapi.dart';

class TopNotes extends StatelessWidget {
  const TopNotes({
    Key? key,
    required this.size,
    required this.img,
    required this.content,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;
  final String img;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage("$imageroot/${img}"), fit: BoxFit.fill),
            )),
        Positioned(
          child: Container(
              height: size.height * 0.1,
              width: size.width * 0.60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  (" ${title}"),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              )),
          bottom: 0,
          left: 0,
        ),
        Positioned(
          child: Container(
              height: size.height * 0.04,
              width: size.width * 0.15,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(14)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  content,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
              )),
          top: 0,
          bottom: 150,
          right: 0,
        ),
        Positioned(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "***",
                  style: TextStyle(fontSize: 30, color: Colors.cyanAccent),
                )),
          ),
          top: 0,
          right: 0,
        )
      ],
    );
  }
}
