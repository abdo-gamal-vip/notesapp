import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';

import '../constant/linkapi.dart';

class adddNote extends StatefulWidget {
  const adddNote({Key? key}) : super(key: key);

  @override
  State<adddNote> createState() => _adddNoteState();
}

class _adddNoteState extends State<adddNote> with Crud {
  GlobalKey<FormState> _tkey = GlobalKey<FormState>();
  GlobalKey<FormState> _ckey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  addNote() async {
    isLoading = true;
    setState(() {});
    try {
      var response = await postRequset(addlink, {
        "users": shardprefs.getString("u_id"),
        "file": shardprefs.getString("n_image"),
        "title": title.text,
        "content": content.text,
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
                      height: 600,
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
                          MaterialButton(
                            color: Colors.teal,
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 140,
                                                width: 80,
                                                child: InkWell(
                                                  onTap: () async {
                                                    XFile? xfile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    File myfile =
                                                        File(xfile!.path);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "asset/gallery.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Text("from gallery"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 140,
                                                width: 80,
                                                child: InkWell(
                                                  onTap: () async {
                                                    XFile? xfile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    File myfile =
                                                        File(xfile!.path);
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "asset/camera.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Text("from gallery"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ));
                            },
                            child: Text(
                              "Choose Image File",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
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
                                        addNote();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()),
                                                (route) => false);
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
