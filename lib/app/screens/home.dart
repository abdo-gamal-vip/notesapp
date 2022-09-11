// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:notesapp/app/screens/about_us.dart';
import 'package:notesapp/app/auth/account_view.dart';
import 'package:notesapp/app/screens/book_mark.dart';
import 'package:notesapp/app/screens/task_view.dart';
import 'package:notesapp/app/screens/view_note.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/themes_service/notify_services.dart';
import 'package:notesapp/themes_service/themes_service.dart';

class Home extends StatefulWidget with Crud {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// ignore: prefer_typing_uninitialized_variables
var notifyHelper;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  List<Widget> item = [
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.task,
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
        widget = const TaskView();
        break;
      case 2:
        widget = const AccountView();
        break;
      case 3:
        widget = const BookMarks();
        break;
      default:
        widget = const AccountView();
    }
    return widget;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SpeedDial(
          backgroundColor: context.theme.backgroundColor,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.add,
                  color: Colors.teal,
                ),
                label: "add Note"),
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
        color: context.theme.backgroundColor,
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
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
    leading: GestureDetector(
        onTap: () {
          ThemesService().swithTheme();
          print("hna");
          notifyHelper.displayNotification(
            title: "theme changed",
            body: Get.isDarkMode ? "active light mode" : "active dark mode",
          );
          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        )),
    actions: [
      IconButton(
          onPressed: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AboutUs()));
          }),
          icon: const Icon(Icons.info_outline)),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 20,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "$imageroot/${shardprefs.getString("profilepic")}"),
                    fit: BoxFit.cover)),
          ))
    ],
    title: const Text("SMART NOTE"),
  );
}
