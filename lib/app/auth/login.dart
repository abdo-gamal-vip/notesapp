// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/screens/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';
import '../../components/customtextform.dart';
import '../../components/small_button.dart';
import '../../components/valid.dart';
import '../../constant/linkapi.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Crud crud = Crud();
  bool isLoading = false;
  login() async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        var response = await crud.postRequset(loginlink, {
          "email": email.text,
          "password": password.text,
        });
        isLoading = false;
        setState(() {});

        if (response['status'] == "success") {
          shardprefs.setString("u_id", response["data"]["u_id"].toString());
          shardprefs.setString("username", response["data"]["username"]);
          shardprefs.setString("password", response["data"]["password"]);
          shardprefs.setString("email", response["data"]["email"]);

          shardprefs.setString("profilepic", response["data"]["profilepic"]);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          setState(() {
            AwesomeDialog(
              context: context,
              title: "تنبيه ",
              body: const Text("البريد الالكترونى خطأ او كلمه المرور"),
            ).show();
          });
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
        padding: const EdgeInsets.all(5),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: [
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Image.network(
                            "https://media.mktg.workday.com/is/image/workday/illustration-people-login?fmt=png-alpha&wid=1000"),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
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
                          hinttype: 'Type Your password',
                          iname: const Icon(Icons.vpn_key),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            child: const Text("Forgot Password?")),
                        const SizedBox(
                          height: 8,
                        ),
                        Smallbutton(
                            txt: "login ",
                            onPreased: () async {
                              await login();
                            }),
                        const SizedBox(
                          height: 6,
                        ),
                        Smallbutton(
                            txt: "Signup ",
                            onPreased: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Signup()));
                            }),
                      ],
                    ))
              ]),
      ),
    );
  }
}
