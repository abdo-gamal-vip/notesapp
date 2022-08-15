import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';

import '../constant/linkapi.dart';

class editNote extends StatefulWidget {
  final notes;
  const editNote({Key? key, required this.notes}) : super(key: key);

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> with Crud {
  GlobalKey<FormState> _tkey = GlobalKey<FormState>();
  GlobalKey<FormState> _ckey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  editNote() async {
    isLoading = true;
    setState(() {});
    try {
      var response = await postRequset(editlink, {
        "n_title": title.text,
        "n_content": content.text,
        "n_id": widget.notes["n_id"].toString(),
        "n_image": widget.notes["n_image"].toString()
      });
      isLoading = false;
      setState(() {});
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    title.text = widget.notes["n_title"].toString();
    content.text = widget.notes["n_content"].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("add Note"),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      height: 400,
                      width: double.infinity,
                      child: Column(
                        children: [
                          TextField(
                            controller: title,
                            key: _tkey,
                            maxLines: 1,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(10)),
                                focusColor: Colors.teal,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(),
                                labelText: "Title",
                                hintText: "Enter Title",
                                prefixIcon: Icon(Icons.title),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.teal))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: content,
                            key: _ckey,
                            maxLines: 10,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(10)),
                                focusColor: Colors.teal,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(),
                                labelText: "Content",
                                hintText: "Enter Note Content",
                                prefixIcon: Icon(Icons.title),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.teal))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(100, 40)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(5),
                                                        bottom: Radius.circular(
                                                            20)))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.lightGreen)),
                                    onPressed: () {
                                      setState(() {
                                        print("key");
                                        editNote();
                                      });
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(100, 40)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(5),
                                                        bottom: Radius.circular(
                                                            20)))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () {
                                      setState(() {
                                        content.clear();
                                        title.clear();
                                      });
                                    },
                                    child: Text(
                                      "Clear",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ]),
                        ],
                      )),
                ]),
              ));
  }
}
