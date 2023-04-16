import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/homepage/homepage.dart';
import 'package:intl/date_symbol_data_local.dart';

class RegisterCases extends StatefulWidget {
  const RegisterCases({super.key});

  @override
  State<RegisterCases> createState() => _RegisterCasesState();
}

class _RegisterCasesState extends State<RegisterCases> {
  final caseDB = FirebaseFirestore.instance.collection('cases');
  final caseIdController = TextEditingController();
  final caseStatusController = TextEditingController();
  final caseTypeController = TextEditingController();
  final caseVerdictController = TextEditingController();
  final defendentNameController = TextEditingController();
  final defendentAddressController = TextEditingController();
  final hearingDateController = TextEditingController();
  final registerDateController = TextEditingController();
  final arrestDateController = TextEditingController();
  final lawyerEnrollmentIdController = TextEditingController();
  final arrestLocationController = TextEditingController();
  final arrestingOfficerController = TextEditingController();

  void postDetails(
      String caseId,
      String caseStatus,
      String caseType,
      String caseVerdict,
      String defendantName,
      String defendantAddress,
      DateTime arrestingDate,
      String arrestLocation,
      String officerName,
      DateTime registerDate,
      DateTime hearingDate,
      String lawyereEnrollmentId) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    print("posting details to firestore");

    caseDB.doc(caseId).set({
      "caseID": caseId,
      "caseStatus": caseStatus,
      "caseType": caseType,
      "caseVerdict": caseVerdict,
      "defendant": defendantName,
      "defendantsAddress": defendantAddress,
      "arrestingDate": arrestingDate,
      "arrestingLocation": arrestLocation,
      "arrestingOfficer": officerName,
      "hearingDate": hearingDate,
      "registerDate": registerDate,
      "lawyerEnrollmentID": lawyereEnrollmentId,
    });

    print("posting details to firestore done");

    Navigator.pop(context);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        title: const Text("Register Cases"),
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: caseIdController,
                  labelText: "Case ID",
                  iconName: CupertinoIcons.doc,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: caseStatusController,
                  labelText: "Case Status (true - pending, false - closed)",
                  iconName: CupertinoIcons.check_mark,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: caseTypeController,
                  labelText: "Case Type",
                  iconName: CupertinoIcons.archivebox,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: caseVerdictController,
                  labelText: "Case Verdict",
                  iconName: CupertinoIcons.ellipsis_circle,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: defendentNameController,
                  labelText: "Defendant's Name",
                  iconName: CupertinoIcons.person,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  labelText: "Defendant's Address",
                  textController: defendentAddressController,
                  iconName: CupertinoIcons.home,
                ),
                const SizedBox(height: 10),
                BasicDateFeild(
                  labelText: "Date of Arrest",
                  textController: arrestDateController,
                  iconName: CupertinoIcons.calendar,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  labelText: "Location of Arrest",
                  textController: arrestLocationController,
                  iconName: CupertinoIcons.location,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  labelText: "Arresting Officer",
                  textController: arrestingOfficerController,
                  iconName: CupertinoIcons.person,
                ),
                const SizedBox(height: 10),
                BasicDateFeild(
                  labelText: "Case Registered on",
                  textController: registerDateController,
                  iconName: CupertinoIcons.calendar,
                ),
                const SizedBox(height: 10),
                BasicDateFeild(
                  textController: hearingDateController,
                  labelText: "Hearing Date",
                  iconName: CupertinoIcons.calendar,
                ),
                const SizedBox(height: 10),
                RegisterCaseDetailsTextfeild(
                  textController: lawyerEnrollmentIdController,
                  labelText: "Lawyer's Enrollment ID",
                  iconName: CupertinoIcons.creditcard,
                ),
                const SizedBox(height: 20),
                RegisterDetails(onTap: () {
                  postDetails(
                    caseIdController.text,
                    caseStatusController.text,
                    caseTypeController.text,
                    caseVerdictController.text,
                    defendentNameController.text,
                    defendentAddressController.text,
                    DateFormat("dd-MM-yyyy").parse(arrestDateController.text),
                    arrestLocationController.text,
                    arrestingOfficerController.text,
                    DateFormat("dd-MM-yyyy").parse(hearingDateController.text),
                    DateFormat("dd-MM-yyyy").parse(registerDateController.text),
                    lawyerEnrollmentIdController.text,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BasicDateFeild extends StatefulWidget {
  final String labelText;
  final IconData? iconName;
  // final bool obscureText;
  dynamic textController;
  BasicDateFeild({
    super.key,
    required this.labelText,
    this.iconName,
    // required this.obscureText,
    required this.textController,
  });

  @override
  State<BasicDateFeild> createState() => _BasicDateFeildState();
}

class _BasicDateFeildState extends State<BasicDateFeild> {
  Color focusColor = Colors.black;
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      style: TextStyle(color: CustomColors().paragraphColor),
      controller: widget.textController,
      format: format,
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
        labelText: widget.labelText,
        labelStyle: TextStyle(color: CustomColors().paragraphColor),
        prefixIcon: Icon(
          CupertinoIcons.calendar,
          color: CustomColors().paragraphColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors().buttonColor, width: 3),
        ),
        focusColor: CustomColors().paragraphColor,
      ),
    );
  }
}

class RegisterCaseDetailsTextfeild extends StatefulWidget {
  final String labelText;
  final IconData? iconName;
  dynamic textController;
  RegisterCaseDetailsTextfeild({
    super.key,
    required this.labelText,
    this.iconName,
    required this.textController,
  });

  @override
  State<RegisterCaseDetailsTextfeild> createState() =>
      _RegisterCaseDetailsTextfeildState();
}

class _RegisterCaseDetailsTextfeildState
    extends State<RegisterCaseDetailsTextfeild> {
  Color focusColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextField(
        style: TextStyle(color: CustomColors().paragraphColor),
        controller: widget.textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 3,
            color: CustomColors().paragraphColor,
          )),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: CustomColors().paragraphColor),
          prefixIcon: Icon(
            widget.iconName,
            color: CustomColors().paragraphColor,
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

class RegisterDetails extends StatelessWidget {
  void Function()? onTap;
  RegisterDetails({super.key, required this.onTap});

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
                  "Upload Details",
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
