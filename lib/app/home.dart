import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/about_us.dart';
import 'package:notesapp/app/auth/account_view.dart';
import 'package:notesapp/app/book_mark.dart';
import 'package:notesapp/app/view_note.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';

import 'add_note.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Navigator.push((context),
                MaterialPageRoute(builder: (context) => const AdddNote()));
          },
          icon: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutUs()));
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
        child: IndexedStack(
          children: [getSelectedWidget(index: index)],
        ),
      ),
    );
  }
}
