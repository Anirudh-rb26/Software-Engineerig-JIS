import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiss/pages/login_register/login/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // uses font "Comfortaa" from google fonts.
        fontFamily: GoogleFonts.comfortaa().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
