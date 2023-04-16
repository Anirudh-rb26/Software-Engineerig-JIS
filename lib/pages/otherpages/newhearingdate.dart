import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/homepage/homepage.dart';

class AssignHearingDate extends StatefulWidget {
  const AssignHearingDate({super.key});

  @override
  State<AssignHearingDate> createState() => _AssignHearingDateState();
}

class _AssignHearingDateState extends State<AssignHearingDate> {
  final searchKeyController = TextEditingController();
  final newDateController = TextEditingController();
  List<String> caseIds = [];

  void postDetails(String caseId, DateTime newDateTime) {
    final caseDB = FirebaseFirestore.instance.collection('cases');

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    print("posting details to firestore");

    caseDB.doc(caseId).update({
      "hearingDate": newDateTime,
    });

    print("posting details to firestore done");

    Navigator.pop(context);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future getCaseId() async {
    print("getting case Id");
    await FirebaseFirestore.instance.collection('cases').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              caseIds.add(document.reference.id);
            },
          ),
        );
  }

  void searchForCaseId(String query, List<String> caseIds) async {
    await FirebaseFirestore.instance.collection('cases').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print("${document.reference.id}");
              caseIds.add(document.reference.id);
            },
          ),
        );
    if (caseIds.contains(query)) {
      print("Contains query, now pushing page");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: true,
            errorText: "Case Selected",
            snackBarColor: Colors.green,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
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
        title: const Text("Assign New Hearing Date"),
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
                  labelText: "Select Case ID",
                  labelStyle: TextStyle(color: CustomColors().paragraphColor),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
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
              DateTimeField(
                style: TextStyle(color: CustomColors().paragraphColor),
                controller: newDateController,
                format: DateFormat("dd-MM-yyyy"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3,
                    color: CustomColors().paragraphColor,
                  )),
                  labelText: "Assign new Date",
                  labelStyle: TextStyle(color: CustomColors().paragraphColor),
                  prefixIcon: Icon(
                    CupertinoIcons.calendar,
                    color: CustomColors().paragraphColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColors().buttonColor, width: 3),
                  ),
                  focusColor: CustomColors().paragraphColor,
                ),
              ),
              UploadDetails(onTap: () {
                postDetails(
                  searchKeyController.text,
                  DateFormat("dd-MM-yyyy").parse(newDateController.text),
                );
              })
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
                  "Select",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.doc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadDetails extends StatelessWidget {
  void Function()? onTap;
  UploadDetails({
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
                  "Upload",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.cloud_upload),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
