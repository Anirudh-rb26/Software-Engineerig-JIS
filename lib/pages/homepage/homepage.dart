import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/pages/otherpages/newhearingdate.dart';
import 'package:jiss/pages/otherpages/pendingcases.dart';
import 'package:jiss/pages/otherpages/querycases.dart';
import 'package:jiss/pages/otherpages/registercases.dart';
import 'package:jiss/pages/otherpages/updatesummary.dart';
import 'package:jiss/pages/otherpages/view_casedocs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // -> update case summary
  // -> query cases
  // -> register cases
  // -> case details
  // -> asign new case date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
        title: const Text("Home"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateCaseSummary(),
                        ),
                      );
                    },
                    title: "Upload Case Documents",
                    imagePath: "assets/images/update.svg",
                  ),
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QueryCases(),
                        ),
                      );
                    },
                    title: "Query Cases",
                    imagePath: "assets/images/search.svg",
                  ),
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterCases(),
                        ),
                      );
                    },
                    title: "Register Cases",
                    imagePath: "assets/images/register.svg",
                  ),
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewCaseDetails(),
                        ),
                      );
                    },
                    title: "Download Documents",
                    imagePath: "assets/images/download.svg",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SortedPendingCases(),
                        ),
                      );
                    },
                    title: "Pending Cases",
                    imagePath: "assets/images/pending.svg",
                  ),
                  ClickableButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AssignHearingDate(),
                        ),
                      );
                    },
                    title: "Assign Hearing Date",
                    imagePath: "assets/images/dates.svg",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClickableButton extends StatelessWidget {
  void Function()? onTap;
  final String title;
  final String imagePath;
  ClickableButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          height: 300,
          width: 250,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors().buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 150,
                  width: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    const Icon(CupertinoIcons.arrow_right),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
