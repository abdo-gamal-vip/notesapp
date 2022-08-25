// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

class AdddNote extends StatefulWidget {
  const AdddNote({Key? key}) : super(key: key);

  @override
  State<AdddNote> createState() => _AdddNoteState();
}

class _AdddNoteState extends State<AdddNote> with Crud {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  File? myfile;
  bool isLoading = false;
  addNotewithphoto() async {
    if (myfile == null) {
      return AwesomeDialog(
        context: context,
        title: "هام",
        body: const Text("برجاء اضافه صوره للملاحظه"),
      ).show();
    }
    isLoading = true;
    setState(() {});
    if (formkey.currentState!.validate()) {
      print("validate");
      var response = await postRequsetFile(
          addlink,
          {
            "users": shardprefs.getString("u_id"),
            "title": title.text,
            "content": content.text,
          },
          myfile!);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
      isLoading = false;
      setState(() {});
      print(response);
      return response;
    }
  }

  addNote() async {
    isLoading = true;
    setState(() {});
    try {
      var response = await postRequset(addwitoutphoto, {
        "users": shardprefs.getString("u_id"),
        "title": title.text,
        "content": content.text,
      });
      isLoading = false;
      setState(() {});
      print(response);
      return response;
    } catch (e) {
      print("$e error e");
    }
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
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formkey,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 600,
                        width: double.infinity,
                        child: Column(
                          children: [
                            TextField(
                              controller: title,
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
                                    builder: (context) => SizedBox(
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
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              5),
                                                          bottom:
                                                              Radius.circular(
                                                                  20)))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.lightGreen)),
                                      onPressed: () async {
                                        if (myfile == null) {
                                          setState(() {
                                            print("add with out photo");
                                            addNote();
                                          });
                                        } else {
                                          setState(() {
                                            print("add with photo");
                                            addNotewithphoto();
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
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
                                                          top: Radius.circular(
                                                              5),
                                                          bottom:
                                                              Radius.circular(
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
