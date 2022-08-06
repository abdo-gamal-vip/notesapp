import 'package:flutter/material.dart';
import 'package:notesapp/app/home.dart';
import 'app/auth/signup.dart';
import 'app/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'home': (context) => Home(),
          'login': (context) => Login(),
          'signup': (context) => Signup(),
        });
  }
}
