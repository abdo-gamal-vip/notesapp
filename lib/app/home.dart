import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/about_us.dart';
import 'package:notesapp/app/edit_note.dart';
import 'package:notesapp/app/top_notes.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/models/model_notes.dart';

import 'add_note.dart';

class Home extends StatefulWidget with Crud {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  Future viewNote() async {
    var response = await postRequset(viewslink, {
      "u_id": shardprefs.getString("u_id"),
    });
    return response;
  }

  @override
  void initState() {
    viewNote();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Navigator.push(
                (context), MaterialPageRoute(builder: (context) => adddNote()));
          },
          icon: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => aboutUs()));
              }),
              icon: Icon(Icons.info_outline)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                setState(() {
                  shardprefs.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                });
              },
            ),
          )
        ],
        backgroundColor: Colors.teal[400],
        title: const Text("SMART NOTE"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: RefreshIndicator(
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
                    if (snapshot.data['status'] == 'fail')
                      return const Center(
                          child: Text(
                        "لا يوجد اى ملاحظات جديده \n من فضلك ادخل ملاحظه",
                        style: TextStyle(fontSize: 20),
                      ));
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data["data"].length,
                        itemBuilder: (context, index) {
                          return CardNotes(
                            noteModel: NotesModel.fromJson(
                                snapshot.data["data"][index]),
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
                  if (snapshot.connectionState == ConnectionState.waiting) ;
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder(
                  future: viewNote(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) if (snapshot.data['status'] ==
                        'fail') {
                      return Text("لا يوجد ملاحظات");
                    }
                    return CarouselSlider.builder(
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: ((context, index, realIndex) {
                        return TopNotes(
                            size: MediaQuery.of(context).size,
                            img: snapshot.data["data"][index]["n_image"] == null
                                ? "text.png"
                                : snapshot.data["data"][index]["n_image"],
                            content: "",
                            title: snapshot.data["data"][index]["n_title"]);
                      }),
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: Duration(seconds: 1)),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
