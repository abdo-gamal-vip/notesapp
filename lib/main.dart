import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notesapp/app/screens/home.dart';
import 'package:notesapp/constant/themes.dart';
import 'package:notesapp/themes_service/themes_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth/signup.dart';
import 'app/auth/login.dart';

late SharedPreferences shardprefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  shardprefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemesService().theme,
        debugShowCheckedModeBanner: false,
        initialRoute: shardprefs.getString("u_id") == null ? 'login' : 'home',
        routes: {
          'home': (context) => Home(),
          'login': (context) => const Login(),
          'signup': (context) => const Signup(),
        });
  }
}
