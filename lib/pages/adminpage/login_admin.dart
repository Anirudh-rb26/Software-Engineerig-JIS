import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/adminpage/register/register.dart';
import 'package:jiss/pages/login_register/login/loginpage.dart';

class LoginAsAdmin extends StatefulWidget {
  const LoginAsAdmin({super.key});

  @override
  State<LoginAsAdmin> createState() => _LoginAsAdminState();
}

class _LoginAsAdminState extends State<LoginAsAdmin> {
  final passwordController = TextEditingController();

  bool checkPassword(String inputString) {
    String password = "admin123";
    if (inputString == password) {
      return true;
    } else {
      return false;
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
                      "Enter Admin Password",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GoBack(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            Navigator.pop(context);
                          },
                        ),
                        LoginButton(
                          onTap: () {
                            if (checkPassword(passwordController.text) ==
                                true) {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return const Center(
                              //       child: CircularProgressIndicator(),
                              //     );
                              //   },
                              // );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );

                              // Navigator.pop(context);
                            } else {
                              CustomSnackbar(
                                success: false,
                                errorText: "Wrong Password",
                                snackBarColor: Colors.red,
                              );
                            }
                          },
                        ),
                      ],
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

class GoBack extends StatelessWidget {
  void Function()? onTap;
  GoBack({super.key, required this.onTap});

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
                  "Go back",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.arrow_left),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
