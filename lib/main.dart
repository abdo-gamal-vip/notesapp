import 'package:flutter/material.dart';

import 'app/auth/login.dart';
import 'app/auth/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/Login",
      routes: {
        "Login": (context) => Signup(),
        "Signup": (context) => Signup(),
      },
    );
  }
}
