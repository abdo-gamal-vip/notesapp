import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/models/model_notes.dart';

class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);

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
                padding: EdgeInsets.all(0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 812 * 120 / Get.height,
                      width: 812 * 120 / Get.height,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal.withOpacity(0.20),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                    ),
                    Container(
                      width: 812 * 200 / Get.height,
                      height: 812 * 100 / Get.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            shardprefs.getString("u_id") == null
                                ? 'loading name'
                                : shardprefs.getString("username").toString(),
                            style: TextStyle(
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
                              child: Text(
                                "change password",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Column(children: [
                  ListTile(
                    onTap: () {
                      Get.to(Home());
                    },
                    leading: Image.asset("asset/svg/editprofile.png"),
                    title: Text("Edit Profile"),
                    trailing: RotatedBox(
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
                    title: Text("Tracking Order"),
                    trailing: RotatedBox(
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
                    title: Text("Notifications"),
                    trailing: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await shardprefs.clear();
                      Get.offAll(Login());
                    },
                    leading: Icon(
                      Icons.logout,
                      color: Colors.teal,
                    ),
                    title: Text("Sign out"),
                    trailing: RotatedBox(
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
