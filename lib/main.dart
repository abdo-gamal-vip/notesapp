import 'package:flutter/material.dart';
import 'package:notesapp/app/screens/home.dart';
import 'package:notesapp/constant/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth/signup.dart';
import 'app/auth/login.dart';

late SharedPreferences shardprefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shardprefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: shardprefs.getString("u_id") == null ? 'login' : 'home',
        routes: {
          'home': (context) => Home(),
          'login': (context) => const Login(),
          'signup': (context) => const Signup(),
        });
  }
}
