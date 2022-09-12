import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/app/screens/about_us.dart';
import 'package:notesapp/app/screens/home.dart';
import 'package:notesapp/app/screens/task_view.dart';
import 'package:notesapp/constant/themes.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/widgets/input_field.dart';

import '../../constant/linkapi.dart';
import '../../themes_service/themes_service.dart';

class AddTaskview extends StatefulWidget {
  const AddTaskview({super.key});

  @override
  State<AddTaskview> createState() => _AddTaskviewState();
}

class _AddTaskviewState extends State<AddTaskview> {
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedRemid = 5;
  List<int> remindList = [5, 10, 15, 20];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(context),
      body: Container(
        margin: const EdgeInsets.only(right: 0),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: HeadingStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              const MyInputFiled(
                controller: null,
                hint: "Enter title here",
                title: "Title",
                widget: null,
              ),
              const MyInputFiled(
                controller: null,
                hint: "Enter Note here",
                title: "Note",
                widget: null,
              ),
              MyInputFiled(
                controller: null,
                hint: DateFormat.yMd().format(_selectedDate),
                title: "Note",
                widget: IconButton(
                    onPressed: () {
                      setState(() {
                        _getDateFromUser();
                      });
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    )),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputFiled(
                    title: "Start Date",
                    controller: null,
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          setState(() {
                            _getTimeFromUser(isStartTime: true);
                          });
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: MyInputFiled(
                    title: "End Date",
                    controller: null,
                    hint: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          setState(() {
                            _getTimeFromUser(isStartTime: false);
                          });
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                ],
              ),
              MyInputFiled(
                  title: "Remind ",
                  hint: "$_selectedRemid minutes early",
                  controller: null,
                  widget: DropdownButton(
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        child: Text(value.toString()),
                        value: value.toString(),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemid = int.parse(newValue!);
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicke();

    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("time canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicke() async {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  _getDateFromUser() async {
    DateTime? _PickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_PickerDate != null) {
      setState(() {
        _selectedDate = _PickerDate;
        print(_selectedDate);
      });
    } else {
      print("its null or something is wrong");
    }
  }

  _AppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.isDarkMode ? Colors.grey : Colors.white10,
      leading: IconButton(
          onPressed: (() {
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => Home()));
          }),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
      actions: [
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
      title: const Text(
        " ",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
