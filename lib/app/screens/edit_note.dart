// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables, duplicate_ignore, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/components/crud.dart';
import '../../constant/linkapi.dart';
import '../../constant/linkapi.dart';

// ignore: camel_case_types
class editNote extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final notes;
  const editNote({Key? key, required this.notes}) : super(key: key);

  @override
  State<editNote> createState() => _editNoteState();
}

// ignore: camel_case_types
class _editNoteState extends State<editNote> with Crud {
  final GlobalKey<FormState> _tkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ckey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  File? myfile;
  bool isLoading = false;
  editNote() async {
    isLoading = true;
    setState(() {});
    try {
      var response;
      if (myfile == null) {
        response = await postRequset(editlink, {
          "n_title": title.text,
          "n_content": content.text,
          "n_id": widget.notes["n_id"].toString(),
          "imagename": widget.notes["n_image"].toString(),
        });
      } else {
        response = await postRequsetFile(
            editlink,
            {
              "n_title": title.text,
              "n_content": content.text,
              "n_id": widget.notes["n_id"].toString(),
              "imagename": widget.notes["n_image"].toString()
            },
            myfile!);
      }

      isLoading = false;
      setState(() {});

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
          title: const Text("add Note"),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 500,
                        width: double.infinity,
                        child: Column(
                          children: [
                            TextField(
                              controller: title,
                              key: _tkey,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusColor: Colors.teal,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  border: const OutlineInputBorder(),
                                  labelText: "Title",
                                  hintText: "Enter Title",
                                  prefixIcon: const Icon(Icons.title),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.teal))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: content,
                              key: _ckey,
                              maxLines: 10,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusColor: Colors.teal,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  border: const OutlineInputBorder(),
                                  labelText: "Content",
                                  hintText: "Enter Note Content",
                                  prefixIcon: const Icon(Icons.title),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.teal))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              color: Colors.teal,
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          height: 160,
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
                                                                  source: ImageSource
                                                                      .gallery);
                                                      myfile =
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
                                                        const Text(
                                                            "from gallery"),
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
                                                      myfile =
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
                                                        const Text(
                                                            "from gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ));
                              },
                              child: const Text(
                                "Choose Image File",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(100, 40)),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      // ignore: unnecessary_const
                                                      const BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              5),
                                                          bottom:
                                                              Radius.circular(
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
                                      child: const Text(
                                        "Save",
                                        // ignore: unnecessary_const
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(100, 40)),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top:
                                                              // ignore: unnecessary_const
                                                              const Radius
                                                                  .circular(5),
                                                          // ignore: unnecessary_const
                                                          bottom: const Radius
                                                              .circular(20)))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () {
                                        setState(() {
                                          content.clear();
                                          title.clear();
                                        });
                                      },
                                      child: const Text(
                                        "Clear",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ]),
                          ],
                        )),
                  ),
                ]),
              ));
  }
}
