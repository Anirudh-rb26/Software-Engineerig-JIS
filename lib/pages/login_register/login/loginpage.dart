import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';

import '../../homepage/homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
                        labelText: "Email Address",
                        iconName: CupertinoIcons.mail,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: CustomTextfield(
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
                    const LoginButton(),
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
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
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
class CustomTextfield extends StatefulWidget {
  final String labelText;
  final IconData? iconName;
  final bool obscureText;
  const CustomTextfield(
      {super.key,
      required this.labelText,
      this.iconName,
      required this.obscureText});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  Color focusColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            focusColor = hasFocus ? CustomColors().buttonColor : Colors.black;
          });
        },
        child: TextField(
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(color: focusColor),
            prefixIcon: Icon(
              widget.iconName,
              color: focusColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CustomColors().buttonColor, width: 3),
            ),
            focusColor: CustomColors().paragraphColor,
          ),
        ),
      ),
    );
  }
}
// Customised Text fields login page widget ends here.