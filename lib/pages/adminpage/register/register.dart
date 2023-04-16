import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/login_register/login/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roleController = TextEditingController();

  final userDB = FirebaseFirestore.instance.collection('users');

  Future<void> registerUser(
      String emailString, String passwordString, String role) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    role = role.toLowerCase();
    print("creating user.");
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then(
          (value) => {postDetailstoFirestore(emailString, role)},
        )
        .catchError((error) {
      showErrorMessage(error.code);
      print("at the end of the function");
    });

    Navigator.pop(context);
  }

  void showErrorMessage(String errorCode) {
    // The email address entered is not found.
    print("error");
    switch (errorCode) {
      case "user-not-found":
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                success: false,
                errorText: "Entered Email ID is incorrect.",
                snackBarColor: Colors.red,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
          return;
        }
      case "email-already-exists":
        {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                success: false,
                errorText:
                    "Entered Email address already exists, use a different Email address.",
                snackBarColor: Colors.red,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
          return;
        }
      case "internal-error":
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                success: false,
                errorText: "Internal Error, try again.",
                snackBarColor: Colors.red,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
          return;
        }
      case "invalid-email":
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                success: false,
                errorText: "Email address entered is not valid.",
                snackBarColor: Colors.red,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              duration: Duration(seconds: 2),
            ),
          );

          return;
        }
      case "wrong-password":
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackbar(
                success: false,
                errorText: "Entered password is incorrect.",
                snackBarColor: Colors.red,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
          return;
        }
    }
  }

  postDetailstoFirestore(String email, String role) {
    print("posting details to firestore");
    const CircularProgressIndicator();
    userDB.doc(email).set({"email": email, "role": role});

    print("posting details to firestore done");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));

    print("is navigator working?");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CustomColors().backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              // Balance Logo.
              Image.asset(
                "assets/images/balance.png",
                color: CustomColors().headlineColor,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 15),
              // Title.
              Text(
                "Judiciary Information System",
                style: TextStyle(
                  color: CustomColors().headlineColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              // Login Page
              Container(
                height: 480,
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: CustomColors().headlineColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      "Enter Details",
                      style: TextStyle(
                        color: CustomColors().paragraphColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
                        textController: emailController,
                        labelText: "Email Address",
                        iconName: CupertinoIcons.mail,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
                        textController: passwordController,
                        labelText: "Password",
                        iconName: CupertinoIcons.padlock,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
                        textController: confirmPasswordController,
                        labelText: "Confirm password",
                        iconName: CupertinoIcons.padlock,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
                        textController: roleController,
                        labelText: "Enter Position",
                        iconName: CupertinoIcons.padlock,
                        obscureText: false,
                      ),
                    ),
                    SignupButton(onTap: () {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        print("password not same");
                        CustomSnackbar(
                          success: false,
                          errorText: "Entered password does not match.",
                          snackBarColor: Colors.red,
                        );
                      } else {
                        print("register called");
                        registerUser(emailController.text,
                            passwordController.text, roleController.text);
                      }
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  void Function()? onTap;
  SignupButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          width: 250,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors().buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
