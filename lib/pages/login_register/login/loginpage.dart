import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    // shows loading page.
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // logs user in.
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (error) {
      showErrorMessage(error.code);
    }

    // pops loading page.
    Navigator.pop(context);
  }

  void showErrorMessage(String errorCode) {
    // The email address entered is not found.
    switch (errorCode) {
      case "user-not-found":
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  CustomSnackbar(errorText: "Entered Email ID is incorrect."),
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
            const SnackBar(
              content: CustomSnackbar(
                errorText:
                    "Entered Email address already exists, use a different Email address.",
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
            const SnackBar(
              content: CustomSnackbar(
                errorText: "Internal Error, try again.",
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
            const SnackBar(
              content: CustomSnackbar(
                errorText: "Email address entered is not valid.",
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
            const SnackBar(
              content: CustomSnackbar(
                errorText: "Entered password is incorrect.",
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
          return;
        }
    }
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
                      "Welcome Back!",
                      style: TextStyle(
                        color: CustomColors().paragraphColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 35),
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
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: ForgotPasswordComponent(),
                    ),
                    const SizedBox(height: 20),
                    LoginButton(
                      onTap: signUserIn,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Login Button widget starts here.
class LoginButton extends StatelessWidget {
  void Function()? onTap;
  LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          alignment: Alignment.center,
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
                  "Log In",
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
// Login Button widget ends here.

// Forgot Password login page widget starts here.
class ForgotPasswordComponent extends StatelessWidget {
  const ForgotPasswordComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          highlightColor: CustomColors().buttonColor,
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const ForgotPassword(),
            //   ),
            // );
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: CustomColors().paragraphColor,
            ),
          ),
        )
      ],
    );
  }
}

// Forgot Password login page widget ends here.
// Customised Text fields login page widget starts here.
// ignore: must_be_immutable
class CustomTextfield extends StatefulWidget {
  final String labelText;
  final IconData? iconName;
  final bool obscureText;
  dynamic textController;
  CustomTextfield(
      {super.key,
      required this.labelText,
      this.iconName,
      required this.obscureText,
      required this.textController});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  Color focusColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          focusColor = hasFocus ? CustomColors().buttonColor : Colors.black;
        });
      },
      child: TextField(
        controller: widget.textController,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: focusColor),
          prefixIcon: Icon(
            widget.iconName,
            color: focusColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors().buttonColor, width: 3),
          ),
          focusColor: CustomColors().paragraphColor,
        ),
      ),
    );
  }
}
// Customised Text fields login page widget ends here.