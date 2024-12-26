import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

ThemeData darkTheme({ bool useMaterial3 = true}) {
  return ThemeData(
      useMaterial3: useMaterial3,
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackgroundColor,
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        centerTitle: true,

      ),


    listTileTheme: const ListTileThemeData(
        iconColor: primaryDarkButtonColor,
      textColor: Colors.white,

    ),
      secondaryHeaderColor: Color(0xff2e3136), // inner dropdown color
      cardColor: Color(0xff363a3d), // outer dropdown color

      drawerTheme: const DrawerThemeData(
        backgroundColor: darkBackgroundColor,
      ),
      canvasColor: Colors.white,// homePageColor,
    shadowColor: Colors.black38
        .withOpacity(0.5)
    ,
      textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white,)), // 0
          displayMedium: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // 1
          displaySmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // 2


          headlineLarge: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // 3
          headlineMedium: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)), // 4
          headlineSmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white,)), // 5

          titleLarge: GoogleFonts.montserrat( textStyle:  const TextStyle( color: Colors.white, fontWeight: FontWeight.bold )), // 6
          titleMedium: GoogleFonts.montserrat(textStyle: const TextStyle( color: Colors.white, fontWeight: FontWeight.w500)), // 7
          titleSmall: GoogleFonts.montserrat( textStyle:  const TextStyle( color: Colors.white, )), // 8
          // homePage (Properties and offices)


          bodyLarge: GoogleFonts.montserrat( textStyle:  const TextStyle( color: Colors.white)), // 9
          bodyMedium: GoogleFonts.openSans( textStyle: const TextStyle(color: Colors.white)), // 10
          bodySmall: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.white,)), // 11


          labelLarge: GoogleFonts.openSans( textStyle:  const TextStyle( color: Colors.white)), // 12
          labelMedium: GoogleFonts.openSans(textStyle: const TextStyle(color: Colors.white,)), // 13 for registering choice
          labelSmall: GoogleFonts.openSans(textStyle: const TextStyle()) // 14

      ),
      iconTheme:  const IconThemeData(
        color: primaryDarkButtonColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,


      ),
      primaryColor: primaryDarkButtonColor,

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        counterStyle: TextStyle(
          color: Colors.white
        ),
        iconColor: primaryDarkButtonColor,
        // labelStyle: TextStyle(
        //   color: Color(0xff6200ee)
        // ),
        labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 8.0),
            borderSide: const BorderSide(color: Color(0xff727476))),



        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 8.0),
            borderSide:  const BorderSide(color: primaryDarkButtonColor, width: 2.0)),

        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.0)),
        prefixIconColor: primaryDarkButtonColor,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( 16.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.0)),
        errorStyle: TextStyle(
          color: Colors.redAccent
        )
      ),
      buttonTheme: const ButtonThemeData(


      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryDarkButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            textStyle: GoogleFonts.openSans( textStyle: const TextStyle(fontSize: 15),
            )
        ),

      ),
      dialogTheme: DialogTheme(
        backgroundColor:  darkBackgroundColor,
        surfaceTintColor: darkBackgroundColor

      ),
      dialogBackgroundColor: Colors.black,
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color.fromARGB(255, 121, 121, 121), width: 2.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              textStyle: GoogleFonts.openSans( textStyle: const TextStyle(fontSize: 15),
              )
          )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: const Color(0xff4d92df),
            textStyle: GoogleFonts.openSans( textStyle: const TextStyle(fontSize: 16),
            )
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primaryDarkButtonColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xff2d2d35),
          type: BottomNavigationBarType.fixed
      ),

  );
}