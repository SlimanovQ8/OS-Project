import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

ThemeData lightTheme({bool useMaterial3 = true}) {
  return ThemeData(
      useMaterial3: useMaterial3,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black
        ),



      toolbarTextStyle: TextStyle(color: Colors.black),
        centerTitle: true,

      ),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(color: Colors.black)
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),

        )
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      sliderTheme: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,

      ),
      canvasColor: Colors.white,// homePageColor,
    secondaryHeaderColor: Colors.white, // inner dropdown color
    cardColor: Colors.grey.withOpacity(0.5), // outer dropdown color

      textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black,)),
          displayMedium: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          displaySmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),


          headlineLarge: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          headlineMedium: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          headlineSmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, )),

          titleLarge: GoogleFonts.montserrat( textStyle:  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          titleMedium: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          titleSmall: GoogleFonts.montserrat( textStyle:  const TextStyle(color: Colors.black,)),
          // homePage (Properties and offices)


          bodyLarge: GoogleFonts.montserrat( textStyle:  const TextStyle(color: Colors.black,)),
          bodyMedium: GoogleFonts.openSans( textStyle: const TextStyle()),
          bodySmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.black,)),


          labelLarge: GoogleFonts.openSans( textStyle:  const TextStyle(color: Colors.black)),
          labelMedium: GoogleFonts.openSans(textStyle: const TextStyle()),// for registering choice
          labelSmall: GoogleFonts.openSans(textStyle: const TextStyle()),
      ),
    iconTheme:  const IconThemeData(
      color: primaryLightButtonColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: lightIconColor1,


    ),
    listTileTheme: ListTileThemeData(
      iconColor: primaryLightButtonColor,
      selectedTileColor: Color(0xffE7DEF8),
    ),
    primaryColor: primaryLightButtonColor,
    shadowColor: Colors.grey.withOpacity(0.5),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      // labelStyle: TextStyle(
      //   color: Color(0xff6200ee)
      // ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 8.0),
          borderSide: const BorderSide(color: Color(0xff727476))),



      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 8.0),
          borderSide:  const BorderSide(color: primaryLightButtonColor, width: 2.0)),

      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      prefixIconColor: primaryLightButtonColor,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 16.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    ),
    buttonTheme: const ButtonThemeData(


    ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryLightButtonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              textStyle: GoogleFonts.openSans()
          ),

  ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color.fromARGB(255, 121, 121, 121), width: 2.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              textStyle: GoogleFonts.openSans( textStyle: const TextStyle(fontSize: 15),
              )
          )
      ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryLightButtonColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      elevation: 8.0,
    )

  );
}