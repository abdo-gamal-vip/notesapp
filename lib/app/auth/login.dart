import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/home.dart';

import '../../components/customtextform.dart';
import '../../components/small_button.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(children: [
          Form(
              child: Column(
            children: [
              Image.network(
                  "https://media.mktg.workday.com/is/image/workday/illustration-people-login?fmt=png-alpha&wid=1000"),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              CustomTextForm(
                hinttype: 'Type Your Username',
                iname: Icon(Icons.person),
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextForm(
                hinttype: 'Type Your Email',
                iname: Icon(Icons.email_outlined),
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text("Forgot Password?")),
              SizedBox(
                height: 8,
              ),
              smallbutton(
                  txt: "login ",
                  onPreased: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  }),
              SizedBox(
                height: 6,
              ),
              smallbutton(
                  txt: "Signup ",
                  onPreased: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    });
                  }),
            ],
          ))
        ]),
      ),
    );
  }
}
