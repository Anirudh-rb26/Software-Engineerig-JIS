import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/homepage/homepage.dart';
import 'package:jiss/pages/otherpages/casepage.dart';
import 'package:jiss/pages/otherpages/viewdocuments.dart';

class ViewCaseDetails extends StatefulWidget {
  ViewCaseDetails({super.key});

  @override
  State<ViewCaseDetails> createState() => _ViewCaseDetailsState();
}

class _ViewCaseDetailsState extends State<ViewCaseDetails> {
  final searchKeyController = TextEditingController();

  List<String> caseIds = [];

// gettind document ids
  Future getCaseId() async {
    await FirebaseFirestore.instance.collection('cases').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              caseIds.add(document.reference.id);
            },
          ),
        );
  }

  void searchForCaseId(String query, List<String> caseIds) {
    if (caseIds.contains(query)) {
      print("Contains query, now pushing page");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ViewDocuments(documentId: '123'),
        ),
      );
    } else {
      print('Case ID not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: false,
            errorText: "Case not found",
            snackBarColor: Colors.red,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
        title: const Text("View Case Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: CustomColors().paragraphColor),
                controller: searchKeyController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: CustomColors().paragraphColor,
                    ),
                  ),
                  labelText: "Select",
                  labelStyle: TextStyle(color: CustomColors().paragraphColor),
                  prefixIcon: Icon(
                    CupertinoIcons.doc,
                    color: CustomColors().paragraphColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColors().buttonColor, width: 3),
                  ),
                  focusColor: CustomColors().paragraphColor,
                ),
              ),
              SearchButton(
                onTap: () {
                  searchForCaseId(searchKeyController.text, caseIds);
                },
              ),
              Text(
                "All Cases:",
                style: TextStyle(color: CustomColors().paragraphColor),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: getCaseId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: caseIds.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2,
                                    color: CustomColors().buttonColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                "Case ID: ${caseIds[index]}",
                                style: TextStyle(
                                    color: CustomColors().paragraphColor),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  void Function()? onTap;
  SearchButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          width: 250,
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
                  "Search",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
