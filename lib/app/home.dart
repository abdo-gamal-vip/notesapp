import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text("SMART NOTE"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            Card(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        "asset/logo.png",
                        width: 100,
                        height: 100,
                      )),
                  Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text(
                          "note titles",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "content note",
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
