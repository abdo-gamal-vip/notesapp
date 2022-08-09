import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
          children: [],
        ),
      ),
    );
  }
}
