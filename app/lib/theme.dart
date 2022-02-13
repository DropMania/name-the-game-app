import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(75, 74, 20, 140),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(75, 74, 20, 140),
  ),
  backgroundColor: Colors.purple[900],
  primaryColor: Colors.purple,
  primarySwatch: Colors.purple,
  primaryTextTheme: GoogleFonts.poppinsTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        shadowColor: MaterialStateProperty.all(
          Colors.purple,
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        )),
  ),
  textTheme: TextTheme(
    headline1: GoogleFonts.paytoneOne(),
    headline2: GoogleFonts.paytoneOne(
      fontSize: 40,
    ),
    headline3: GoogleFonts.paytoneOne(
      fontSize: 30,
    ),
    bodyText1: GoogleFonts.paytoneOne(),
    button: GoogleFonts.paytoneOne(
        textStyle: const TextStyle(decorationThickness: 5, fontSize: 20)),
  ),
);
