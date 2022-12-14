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
                  image: NetworkImage("$imageroot/$img"), fit: BoxFit.fill),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
              height: size.height * 0.06,
              width: size.width * 0.70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  (" $title"),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
              )),
        ),
        Positioned(
          top: 0,
          bottom: 150,
          right: 0,
          child: Container(
              height: size.height * 0.20,
              width: size.width * 0.10,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(14)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  content,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
              )),
        ),
        // ignore: prefer_const_constructors
        Positioned(
          top: 0,
          right: 0,
          child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.bookmark,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
