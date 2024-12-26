import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
int? initScreen;
bool? isDark;
 firstTimeCheck() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen =  preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1 );
  await preferences.setBool('isDark', false );
  isDark = preferences.getBool('isDark');


 }

void changeFirst(BuildContext context) async {

 await firstTimeCheck();
//  Navigator.push(
//   context,
//   MaterialPageRoute(builder: (_) => const LogInPage()),
//  );
}

setTheme({required bool isDarkMode}) async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 await preferences.setBool('isDark', isDarkMode );
 isDark = preferences.getBool('isDark');
}

getTheme() async {
 SharedPreferences preferences = await SharedPreferences.getInstance();
 isDark =  preferences.getBool('isDark');
}