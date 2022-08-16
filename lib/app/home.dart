import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/about_us.dart';
import 'package:notesapp/app/edit_note.dart';
import 'package:notesapp/app/top_notes.dart';
import 'package:notesapp/app/view_note.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/models/model_notes.dart';

import 'add_note.dart';

class Home extends StatefulWidget with Crud {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> item = [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.bookmark_add,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    ),
  ];
  int index = 1;
  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = ViewNotes();
        break;
      case 1:
        widget = ViewNotes();
        break;
      case 2:
        widget = const aboutUs();
        break;
      default:
        widget = ViewNotes();
    }
    return widget;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Navigator.push((context),
                MaterialPageRoute(builder: (context) => const adddNote()));
          },
          icon: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => aboutUs()));
              }),
              icon: const Icon(Icons.info_outline)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                setState(() {
                  shardprefs.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                });
              },
            ),
          )
        ],
        backgroundColor: Colors.teal[400],
        title: const Text("SMART NOTE"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: item,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        color: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: getSelectedWidget(index: index),
      ),
    );
  }
}
