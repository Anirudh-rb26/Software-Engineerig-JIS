import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiss/pages/homepage/homepage.dart';
import 'package:jiss/pages/login_register/login/loginpage.dart';

class CheckifSignedin extends StatelessWidget {
  const CheckifSignedin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // user logged in
            return const HomePage();
          } else {
            // user is notlogged in
            return LoginPage();
          }
        },
      ),
    );
  }
}
