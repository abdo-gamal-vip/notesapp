import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/screens/top_notes.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import '../../components/cardnote.dart';
import '../../models/model_notes.dart';
import 'edit_note.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({Key? key}) : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> with Crud {
  Future viewNote() async {
    const Duration(milliseconds: 50);
    var response = await postRequset(viewslink, {
      "u_id": shardprefs.getString("u_id"),
    });
    return await response;
  }

  @override
  void initState() {
    viewNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            viewNote();
          });
        },
        child: ListView(
          children: [
            FutureBuilder(
              future: viewNote(),
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
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => editNote(
                                    notes: snapshot.data["data"][index])));
                          },
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
            FutureBuilder(
                future: viewNote(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data['status'] == 'fail') {
                    return const Text("لا يوجد ملاحظات");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CarouselSlider.builder(
                    itemCount: snapshot.data["data"].length,
                    itemBuilder: ((context, index, realIndex) {
                      return TopNotes(
                          size: MediaQuery.of(context).size,
                          img: snapshot.data["data"][index]["n_image"] ??
                              "text.png",
                          content: "",
                          title: snapshot.data["data"][index]["n_title"]);
                    }),
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
