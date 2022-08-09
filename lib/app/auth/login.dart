import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import '../../components/customtextform.dart';
import '../../components/small_button.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

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
        var response = await crud.postRequset(Loginlink, {
          "email": email.text,
          "password": password.text,
        });
        isLoading = false;
        setState(() {});

        if (response['status'] == "success") {
          shardprefs.setString("id", response["data"]["u_id"].toString());
          shardprefs.setString("username", response["data"]["username"]);
          shardprefs.setString("password", response["data"]["password"]);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          setState(() {
            AwesomeDialog(
              context: context,
              title: "تنبيه ",
              body: Text("البريد الالكترونى خطأ او كلمه المرور"),
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
        padding: EdgeInsets.all(5),
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: [
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
                          valid: (val) {
                            return emailValid(
                              val!,
                              validInput(val, 7, 30),
                            );
                          },
                          mycontroller: email,
                          hinttype: 'Type Your Email',
                          iname: Icon(Icons.email_outlined),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomTextForm(
                          valid: (val) {
                            return validInput(val!, 6, 30);
                          },
                          mycontroller: password,
                          hinttype: 'Type Your password',
                          iname: Icon(Icons.vpn_key),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
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
