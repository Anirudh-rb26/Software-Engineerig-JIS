import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiss/firebase_options.dart';
import 'package:jiss/pages/homepage/homepage.dart';
import 'package:jiss/pages/otherpages/casepage.dart';
import 'package:jiss/pages/otherpages/newhearingdate.dart';
import 'package:jiss/pages/otherpages/pendingcases.dart';
import 'package:jiss/pages/otherpages/querycases.dart';
import 'package:jiss/pages/otherpages/registercases.dart';
import 'package:jiss/pages/otherpages/updatesummary.dart';
import 'package:jiss/pages/otherpages/viewdocuments.dart';
import 'package:jiss/services/user_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        primarySwatch: Colors.purple,
        // uses font "Comfortaa" from google fonts.
        fontFamily: GoogleFonts.comfortaa().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const UserManagement(),
      // home: SortedPendingCases(),
    );
  }
}
