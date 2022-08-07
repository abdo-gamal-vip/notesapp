import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';

import '../../components/customtextform.dart';
import '../../components/small_button.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Crud crud = Crud();
  login() async {
    if (formkey.currentState!.validate()) {
      try {
        var response = await crud.postRequset(Loginlink, {
          "email": email.text,
          "password": password.text,
        });
        if (response['status'] == "success") {
          return navigator!.pushReplacementNamed("home");
        } else {
          print("login failled");
        }
      } catch (e) {
        print("$e error e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(children: [
          Form(
              key: formkey,
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
                    valid: (val) {},
                    mycontroller: email,
                    hinttype: 'Type Your Username',
                    iname: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextForm(
                    valid: (val) {},
                    mycontroller: password,
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
                      onPreased: () async {
                        await login();
                      }),
                  SizedBox(
                    height: 6,
                  ),
                  smallbutton(
                      txt: "Signup ",
                      onPreased: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Signup()));
                      }),
                ],
              ))
        ]),
      ),
    );
  }
}