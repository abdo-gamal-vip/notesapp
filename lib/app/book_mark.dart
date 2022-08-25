import 'package:flutter/material.dart';
import 'package:notesapp/components/crud.dart';
import '../components/cardnote.dart';
import '../constant/linkapi.dart';
import '../main.dart';
import '../models/model_notes.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key, this.notes}) : super(key: key);
  final notes;

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> with Crud {
  Future viewNoteBook() async {
    const Duration(milliseconds: 50);
    var response = await postRequset(viewsbooklink, {
      "n_users": shardprefs.getString("u_id").toString(),
      "n_bookmark": "true",
    });
    return await response;
  }

  @override
  void initState() {
    viewNoteBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            viewNoteBook();
          });
        },
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "<< BookMarks >>",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: viewNoteBook(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail') {
                    return const Center(
                        child: Text(
                      "لا يوجد اى ملاحظات جديده \n من فضلك ادخل ملاحظه",
                      style: TextStyle(fontSize: 20),
                    ));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) {
                        return CardNotes(
                          noteModel:
                              NotesModel.fromJson(snapshot.data["data"][index]),
                          ontap: () {},
                          nn_id:
                              snapshot.data["data"][index]["n_id"].toString(),
                        );
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {}
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
