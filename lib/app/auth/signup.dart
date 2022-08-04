import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/auth/login.dart';

import '../../components/customtextform.dart';
import '../../components/small_button.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                "SIGNUP",
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
              CustomTextForm(
                hinttype: 'Type Your Password',
                iname: Icon(Icons.password_outlined),
              ),
              SizedBox(
                height: 8,
              ),
              smallbutton(
                  txt: "Create Account",
                  onPreased: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  }),
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
                  txt: "signup ",
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
