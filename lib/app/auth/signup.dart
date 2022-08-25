import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/valid.dart';
import 'package:notesapp/constant/linkapi.dart';
import '../../components/customtextform.dart';
import '../../components/small_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = true;
  final Crud _crud = Crud();

  signup() async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequset(Signuplink, {
          "username": username.text,
          "email": email.text,
          "password": password.text,
        });
        isLoading = false;

        setState(() {});
        if (response['status'] == "success") {
          print("sucess");
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          print("signup failled");
        }
      } catch (e) {
        print("signup fail $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == false
          ? (const Center(
              child: CircularProgressIndicator(),
            ))
          : Container(
              padding: const EdgeInsets.all(5),
              child: ListView(children: [
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Image.network(
                            "https://media.mktg.workday.com/is/image/workday/illustration-people-login?fmt=png-alpha&wid=1000"),
                        const Text(
                          "SIGNUP",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 4, 20);
                          },
                          mycontroller: username,
                          hinttype: 'Type Your Username',
                          iname: const Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextForm(
                          valid: (val) {
                            return emailValid(
                              val!,
                              validInput(val, 7, 30),
                            );
                          },
                          mycontroller: email,
                          hinttype: 'Type Your Email',
                          iname: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 6, 30);
                          },
                          mycontroller: password,
                          hinttype: 'Type Your Password',
                          iname: const Icon(Icons.password_outlined),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        smallbutton(
                            txt: "Create Account",
                            onPreased: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              });
                            }),
                        smallbutton(
                            txt: "login ",
                            onPreased: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              });
                            }),
                        const SizedBox(
                          height: 6,
                        ),
                        smallbutton(
                            txt: "signup ",
                            onPreased: () {
                              setState(() {
                                signup();
                              });
                            }),
                      ],
                    ))
              ]),
            ),
    );
  }
}
