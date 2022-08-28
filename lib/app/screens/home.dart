// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notesapp/app/screens/about_us.dart';
import 'package:notesapp/app/auth/account_view.dart';
import 'package:notesapp/app/screens/book_mark.dart';
import 'package:notesapp/app/screens/task_view.dart';
import 'package:notesapp/app/screens/view_note.dart';
import 'package:notesapp/components/crud.dart';

class Home extends StatefulWidget with Crud {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> item = [
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.bookmark_add,
      size: 30,
    ),
    const Icon(
      Icons.person,
      size: 30,
    ),
  ];
  int index = 1;
  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const ViewNotes();
        break;
      case 1:
        widget = const BookMarks();
        break;
      case 2:
        widget = const AccountView();
        break;
      default:
        widget = const ViewNotes();
    }
    return widget;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SpeedDial(
          backgroundColor: Colors.teal,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(child: Icon(Icons.add), label: "add Note"),
            SpeedDialChild(
                child: Icon(Icons.task),
                label: "add Task",
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TaskView())))
          ]),
      appBar: _AppBar(context),
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
        child: IndexedStack(
          children: [getSelectedWidget(index: index)],
        ),
      ),
    );
  }
}

_AppBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(onTap: () {}, child: Icon(Icons.dark_mode)),
    actions: [
      IconButton(
          onPressed: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AboutUs()));
          }),
          icon: const Icon(Icons.info_outline)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {},
        ),
      )
    ],
    title: const Text("SMART NOTE"),
  );
}
