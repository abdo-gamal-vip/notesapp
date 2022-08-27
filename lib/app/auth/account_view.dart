// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_local_variable, prefer_const_constructors

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';
import '../../constant/linkapi.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key, this.notes}) : super(key: key);
  final notes;
  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> with Crud {
  late File myfile;

  uploadprofilepic() async {
    var response = await postRequsetFile(
        addprofilelink,
        {
          "u_id": shardprefs.getString("u_id"),
        },
        myfile);
    if (myfile != null) {
      setState(() {
        AwesomeDialog(
            context: context,
            title: " تم رفع الصوره",
            body: Center(
              child: Text(
                  "تم رفع الصوره بنجاح لتظهر الصوره الجديده برجاء اعاده تسجيل الدخول",
                  textAlign: TextAlign.center),
            )).show();
        shardprefs.setString("profilepic", response["data"]["profilepic"]);
      });
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 140,
                                          width: 80,
                                          child: InkWell(
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              Navigator.of(context).pop();
                                              myfile = File(xfile!.path);
                                              setState(() async {
                                                await uploadprofilepic();

                                                print("done");
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "asset/gallery.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                const Text("from gallery"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 140,
                                          width: 80,
                                          child: InkWell(
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              Navigator.of(context).pop();
                                              myfile = File(xfile!.path);
                                              setState(() {
                                                uploadprofilepic();
                                                print("done");
                                              });
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "asset/camera.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                const Text("from gallery"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ));
                      },
                      child: Container(
                          height: 812 * 120 / Get.height,
                          width: 812 * 120 / Get.height,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal.withOpacity(0.20),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "$imageroot/${shardprefs.getString("profilepic")}"))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 812 * 200 / Get.height,
                      height: 812 * 90 / Get.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            shardprefs.getString("u_id") == null
                                ? 'loading name'
                                : shardprefs.getString("username").toString(),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            shardprefs.getString("u_id") == null
                                ? 'loading name'
                                : shardprefs.getString("email").toString(),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(Home());
                              },
                              child: const Text(
                                "change password",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              )),
                          Text("upload profile pic"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(children: [
                  ListTile(
                    onTap: () {
                      Get.to(Home());
                    },
                    leading: Image.asset("asset/svg/editprofile.png"),
                    title: const Text("Edit Profile"),
                    trailing: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(Home());
                    },
                    leading: Image.asset("asset/svg/editprofile.png"),
                    title: const Text("Tracking Order"),
                    trailing: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(Home());
                    },
                    leading: Image.asset("asset/svg/editprofile.png"),
                    title: const Text("Notifications"),
                    trailing: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      setState(() {
                        shardprefs.clear();
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("login", (route) => false);
                      });
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.teal,
                    ),
                    title: const Text("Sign out"),
                    trailing: const RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
