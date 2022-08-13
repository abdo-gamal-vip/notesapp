import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/models/model_notes.dart';

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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: widget.noteModel.nImage.toString().contains("https://")
                    ? Image.network(
                        "${widget.noteModel.nImage}",
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
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    "${widget.noteModel.nContent}",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        deleten(widget.nn_id, context);
                      });
                    },
                  ),
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content:
                                Text("Are you sure want to delete this note?"),
                            actions: [
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  setState(() {
                                    deleten(widget.nn_id, context);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
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
