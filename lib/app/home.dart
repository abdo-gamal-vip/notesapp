import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

import 'noteview.dart';

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
                (context), MaterialPageRoute(builder: (context) => AddView()));
          },
          icon: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
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
                              content:
                                  "${snapshot.data["data"][index]["n_content"]}",
                              ontap: () {},
                              title:
                                  "${snapshot.data["data"][index]["n_title"]}");
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) ;
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
