// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/models/model_notes.dart';
import '../constant/linkapi.dart';

class CardNotes extends StatefulWidget with Crud {
  final NotesModel noteModel;
  CardNotes(
      {Key? key,
      required this.ontap,
      required this.nn_id,
      required this.noteModel})
      : super(key: key);

  String nn_id;

  void Function() ontap;
  @override
  State<CardNotes> createState() => _CardNotesState();
}

class _CardNotesState extends State<CardNotes> with Crud {
  @override
  void initState() {
    super.initState();
  }

  var _checked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: widget.noteModel.nImage.toString().contains(".")
                    ? Image.network(
                        "$imageroot/${widget.noteModel.nImage}",
                        width: 100,
                        height: 100,
                      )
                    : Image.asset(
                        "asset/logo.png",
                        width: 100,
                        height: 100,
                      )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    "${widget.noteModel.nTitle}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    "${widget.noteModel.nContent}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                      color: widget.noteModel.n_bookmark == "false"
                          ? Colors.red
                          : Colors.teal,
                      disabledColor: Colors.grey,
                      focusColor: Colors.red,
                      onPressed: () {
                        _checked = !_checked;
                        setState(() {
                          if (_checked == true) {
                            bookmark(widget.nn_id, context, "true");
                            print("t");
                          }
                          if (_checked == false) {
                            bookmark(widget.nn_id, context, "false");
                            print("f");
                          }
                        });
                      },
                      icon: const Icon(Icons.bookmark)),
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          // ignore: prefer_const_constructors
                          return AlertDialog(
                            title: const Text("Delete"),
                            content: const Text(
                                "Are you sure want to delete this note?"),
                          );
                        });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
