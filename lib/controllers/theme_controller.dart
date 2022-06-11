import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences? sharedPreferences;
  ThemeController({Key? key, @required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void setTheme(bool darkTheme) {
    _darkTheme = darkTheme;
    sharedPreferences!.setBool('theme', _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences!.getBool('theme') ?? false;
    update();
  }

}