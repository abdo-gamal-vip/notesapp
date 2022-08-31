import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemesService {
  // ignore: non_constant_identifier_names
  final box = GetStorage();
  final key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);
  bool _loadThemeFromBox() {
    return box.read(key) ?? false;
  }

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void swithTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
