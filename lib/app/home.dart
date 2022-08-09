import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

class Home extends StatefulWidget with Crud {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  Future addNote() async {
    var response = await postRequset(viewslink, {
      "u_id": shardprefs.getString("u_id"),
    });
    return response;
  }

  @override
  void initState() {
    addNote();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
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
        child: ListView(
          children: [
            FutureBuilder(
              future: addNote(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) {
                        return Text(
                            "${snapshot.data["data"][index]["n_title"]}");
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) ;
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
